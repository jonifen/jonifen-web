---
type: "blog"
title: "Testing Mobile App in AWS Device Farm using Appium and Node"
description: ""
date: 2021-03-05T11:02:32Z
author: "Jon"
tags: ["programming", "javascript", "react-native", "aws", "node"]
---

*Warning: this post is quite code heavy as I offer our solution as an example*

At work, we've been working on a mobile app for our customers. We've been looking at automated testing to interact with the app like a user would on a device and came across Appium and Detox as potential options that wouldn't cost too much to run.

As we primarily worked on Windows machines, Detox was out of the running as it seems to be only guaranteed support on MacOS, so we started looking at Appium instead. AWS Device Farm supports this already, so this looked promising and a good place to start.

We were able to get some tests running locally using WebDriver.io and Appium, but these didn't work in the AWS Device Farm instance of Appium and the documentation suggested an alternative approach, although some areas seemed kind of vague, so this is how we got to the bottom of it.

*Disclaimer: The test setup below is for Android only. As we used Windows machines for this work, we were unable to get any iOS tests working at this point.*

## Example

This is how we did it, albeit with some slight changes to anonymise file names etc. but the basic concept remains.

### Test files

I created a file that contained functions that would perform common interactions with the app so that the tests would be cleaner and easier to understand later.

An example of this is:

```js
// e2e/test/actions.js

const DEFAULT_ACTION_TIMEOUT = 15000;

const Actions = function () {
  this.getElement = async function (locator, timeout = DEFAULT_ACTION_TIMEOUT) {
    if (!locator) throw new Error("Locator not specified");

    const element = await $(locator);
    await element.waitForDisplayed({ timeout: timeout });
    return element;
  };

  this.clickElement = async function (locator, timeout = DEFAULT_ACTION_TIMEOUT) {
    const button = await this.getElement(locator, timeout);
    await button.click();
  };

  this.inputContent = async function (locator, value = '', timeout = DEFAULT_ACTION_TIMEOUT) {
    const element = await this.getElement(locator, timeout);
    await element.setValue(value);
  };
};
```

The above has functions that just gets an element, clicks an element or inputs a value into an element. Pretty simple stuff, but it's only a guide to what we need to do anyway.

Now I'm able to create an actual test using the actions that were created:

```js
// e2e/test/scenarios/can-enter-name-and-progress.e2e.js

const Actions = require("../actions");

describe("Test", () => {
  const actions = new Actions();

  it("should be able to enter a name, submit and progress to next screen", () => {
    await actions.inputContent("~Name", "Fred", 5000);
    await actions.clickElement("~Submit");

    const heading = await actions.getElement("~Heading");
    expect(heading).toBeDefined();
  });
});
```

This test, again very simple, just checks that the heading exists after a user enters a name and clicks a submit button. I probably don't need to go through all this, but it's just to paint a full picture as there may be someone who is completely new to all this or uses a different test library. You may be able to use Jest or whatever instead, but it seems at the minute Mocha works just fine, and the syntax is very similar.

### WebDriver.io configs

I now need to create some WebDriver.io config files to ensure it works properly. I say "some" configs, because by breaking the configs into multiple files, we can handle both local runs and remote runs in Device Farm with the same shared config, changing only what is needed for the different environments.

```js
// e2e/wdio.shared.conf.js

exports.config = {
  runner: "local",
  maxInstances: 1,
  path: "/wd/hub",
  port: 4723,
  logLevel: "info",
  depreciationWarnings: true,
  bail: 0,
  waitForTimeout: 10000,
  connectionRetryTimeout: 120000,
  connectionRetryCount: 3,
  specs: ["./test/scenarios/**/*.e2e.js"],
  framework: "mocha",
  reporters: ["spec"],
  mochaOpts: {
    timeout: 60000
  }
};
```

```js
// e2e/wdio.android.local.conf.js

// Make sure you change the app path to whatever suits your setup!

const path = require("path");
const { config } = require("./wdio.shared.conf");

config.capabilities = [
  {
    maxInstances: 1,
    platformName: "Android",
    deviceName: "Android Emulator",
    app: path.resolve(__dirname, "../android/app/build/outputs/apk/release/app-release-unsigned.apk"),
    automationName: "UiAutomator2"
  }
];

config.browser: "";

exports.config = config;
```

```js
// e2e/wdio.android.conf.js

const { config } = require("./wdio.shared.conf");

config.capabilities = [
  {
    maxInstances: 1,
  }
];

config.browser: "";

exports.config = config;
```

Now we have those configs in place, we need a package.json file specific to the e2e tests because of how they're packaged for Device Farm. Please note that the versions referenced for the packages are what I used when I got things working. Depending on when you're following this post, you may find the versions are much higher and things may not work quite as expected.

You may choose to use latest versions straight away - this might actually save you time. But if you come across problems, I'd suggest using the versions below, and upgrade versions from there. Please get in touch (or contribute to the post via a PR) if things get out of date.

```json
{
  "name": "App",
  "version": "0.0.1",
  "private": true,
  "scripts": {
    "package": "npm install && npx npm-bundle && zip -r e2e-tests.zip *.tgz && rm *.tgz",
    "test:android": "npx wdio ./wdio.android.conf.js",
    "test:android:local": "npx wdio ./wdio.android.local.conf.js"
  },
  "dependencies": {
    "@wdio/cli": "^7.0.9",
    "@wdio/local-runner": "^7.0.9",
    "@wdio/mocha-framework": "^7.0.7",
    "@wdio/spec-reporter": "^7.0.7",
    "@wdio/sync": "^7.0.9",
    "wdio-appium-service": "^0.2.3",
    "webdriverio": "^7.0.9"
  },
  "devDependencies": {
    "glob": "^7.1.6",
    "npm-bundle": "^3.0.3"
  },
  "bundledDependencies": [
    "@wdio/cli",
    "@wdio/local-runner",
    "@wdio/mocha-framework",
    "@wdio/spec-reporter",
    "@wdio/sync",
    "wdio-appium-service",
    "webdriverio"
  ]
}
```

### Appium Config

And finally, the appium config YAML file (e2e/appium.android.yml). This was the default that AWS Device Farm provided with a few minor changes, mainly with the test commands:

```yaml
version: 0.1

phases:
  install:
    commands:
      - export APPIUM_VERSION=1.16.0
      - avm $APPIUM_VERSION
      - ln -s /usr/local/avm/versions/$APPIUM_VERSION/node_modules/.bin/appium /usr/local/avm/versions/$APPIUM_VERSION/node_modules/appium/bin/appium.js

      - echo "Navigate to test package directory"
      - cd $DEVICEFARM_TEST_PACKAGE_PATH
      - npm install *.tgz

  pre_test:
    commands:
      - echo "Start appium server"
      - >-
        appium --log-timestamp --device-name $DEVICEFARM_DEVICE_NAME
        --platform-name $DEVICEFARM_DEVICE_PLATFORM_NAME --app $DEVICEFARM_APP_PATH
        --automation-name UiAutomator2 --udid $DEVICEFARM_DEVICE_UDID
        --chromedriver-executable $DEVICEFARM_CHROMEDRIVER_EXECUTABLE >> $DEVICEFARM_LOG_DIR/appiumlog.txt 2>%1 &

      - >-
        start_appium_timeout=0;
        while [ true ];
        do
          if [ $start_appium_timeout -gt 60 ];
          then
            echo "appium server never started in 60 seconds. Exiting";
            exit 1;
          fi;
          grep -i "Appium REST http interface listener started on 0.0.0.0:4723" $DEVICEFARM_LOG_DIR/appiumlog.txt >> /dev/null 2>%1 &;
          if [ $? -eq 0 ];
          then
            echo "Appium REST http interface listener started on 0.0.0.0:4723";
            break;
          else
            echo "Waiting for appium server to start. Sleeping for 1 second.";
            sleep 1;
            start_appium_timeout=$((start_appium_timeout+1));
          fi;
        done;

  test:
    commands:
      - echo "Navigate to test source code"
      - cd $DEVICEFARM_TEST_PACKAGE_PATH/node_modules/*
      - echo "Start Appium Node test"
      - npm run test:android

  post_test:
    commands:

  artifacts:
    - $DEVICEFARM_LOG_DIR
```

### Create the package for Device Farm

To create the package, we just need to run the package script as specified in the package.json file.

```bash
npm run package
```


## Device Farm

So from this point, go into AWS Device Farm, created a new test and uploaded the APK (I uploaded the same one from the path referenced in the local wdio config above - so you can likely do the same). I then uploaded the package I created earlier, copied and pasted the Appium config into the window and selected a few devices. At first I only picked one device, but you could actually select multiple devices of various specifications at this point too.


## Conclusion

And that's pretty much it. Following this should get you to a point where you're able to run tests both locally and on AWS Device Farm. Having problems? Get in touch!

PRs are welcomed, and credit will *always* be given.
