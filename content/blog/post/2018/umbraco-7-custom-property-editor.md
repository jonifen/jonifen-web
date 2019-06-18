---
type: "post"
description: "Recently, I've been working on creating an implementation of Umbraco CMS for the Marketing team at work to use for quickly creating content for promotions etc..."
date: "2018-08-19T13:18:18Z"
title: "Umbraco 7: Create a custom Property Editor"
author: "Jon"
tags: [
	"programming",
	"umbraco",
  "umbraco7",
	"c#"
]

---

Recently, I've been working on creating an implementation of Umbraco CMS for the Marketing team at work to use for quickly creating content for promotions etc. and the SEO Manager has asked what we could implement to benefit them in terms of SEO (Search Engine Optimisation for those who don't know).

## Requirements
Now, until working on this, I knew what SEO was, but had no idea what it entailed, so working with the SEO Manager, we outlined the following requirements for our initial (MVP) release. He needed to be able to edit the following:

 - Page title
 - Meta description
 - Meta robots (we needed it to be a text field, so the options could be added easier)
 - Meta Canonical

Other SEO things like Meta keywords etc. weren't important to him at this stage, so we won't include that at this point (but it's really easy to add later on, as you'll see shortly).

## Initial Steps
I had a look at a few Umbraco plugins out there to see what they would offer, but none of them really covered what we wanted in the way that we wanted to use it, so it meant we'd have to consider making our own plugin, which was, again, something I'd never done before!
I did look at creating it through a Document Type, but I thought a plugin would offer a much cleaner approach and would add less bloat to the resulting templates.

## Development
Following the tutorial at [Umbraco Github Tutorials](http://umbraco.github.io/Belle/#/tutorials/CreatingAPropertyEditor), I added a new plugin into our Umbraco project with the following files (note that I've replaced any instance of my company name with 'Company' to adhere with the terms of my contract regarding personal blogs):

~/App_Plugins/SeoMetadataEditor/package.manifest
```
{
  propertyEditors: [
    {
      alias: "Company.SeoMetadataEditor",
      name: "SEO Meta tags editor",
      editor: {
        view: "~/App_Plugins/SeoMetadataEditor/seometadataeditor.html"
      }
    }
  ],
  javascript: [
    "~/App_Plugins/SeoMetadataEditor/seometadataeditor.js"	
  ]
}
```

~/App_Plugins/SeoMetadataEditor/seometadataeditor.html
```
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <title></title>
</head>
<body>
  <div ng-controller="Company.SeoMetadataEditor">
    <div>
      <label class="control-label" for="title">
        Page Title
      </label>
      <input name="title" type="text" ng-model="model.value.title" />
    </div>
    <hr />
    <div>
      <h3>Meta Tags</h3>
    </div>
    <div>
      <label class="control-label" for="description">
        Description
      </label>
      <textarea name="description" ng-model="model.value.description"></textarea>
    </div>
    <div>
      <label class="control-label" for="robots">
        Robots
      </label>
      <input name="robots" type="text" ng-model="model.value.robots" />
    </div>
    <div>
      <label class="control-label" for="canonical">
        Canonical URL
      </label>
      <input name="canonical" type="text" ng-model="model.value.canonical" />
    </div>
  </div>
</body>
</html>
```

~/App_Plugins/SeoMetadataEditor/seometadataeditor.js
```
angular.module("umbraco")
  .controller("Company.SeoMetadataEditor",
  function () {
    alert("The controller has landed");
  });
```

I had to create a data type in Umbraco to contain the property type, but I was able to add the new type to a Document Type, create a Content page from it, edit the values and save them. The data could be recalled if I went to re-edit the content at a later date too.

However, consuming the data was not straight-forward as in my Razor template, I ended up with the following (as a test to see what data I got out):
```
@inherits Umbraco.Web.Mvc.UmbracoTemplatePage<ContentModels.PageToTestSeo>
@using ContentModels = Umbraco.Web.PublishedContentModels;
@{
    Layout = null;
}

@Model.Content.Metadata
```

Which, when loaded in the browser would return a JSON payload as a string. I needed to deserialize it to an object.

After reading some documentation, I decided to take a look at how other plugins did it, and I ended up coming across [seo-metadata](https://github.com/ryanlewis/seo-metadata) by Ryan Lewis on Github. He created a C# project that inherited from some Umbraco types, and performed the mapping that way. This felt a lot cleaner than starting to hack at the payload in every template before I could use the values, so I went down that route and ended up with the following (also included inside our Umbraco project):

~/Plugins/SeoMetadataEditor/SeoMetadata.cs
```
namespace MarketingCms.Plugins.SeoMetadataEditor
{
    public class SeoMetadata
    {
        public string Title { get; set; }
        public string Description { get; set; }
        public string Robots { get; set; }
        public string Canonical { get; set; }
    }
}
```

~/Plugins/SeoMetadataEditor/SeoMetadataEditorPVC.cs
```
using Newtonsoft.Json;
using System;
using Umbraco.Core.Logging;
using Umbraco.Core.Models.PublishedContent;
using Umbraco.Core.PropertyEditors;

namespace MarketingCms.Plugins.SeoMetadataEditor
{
  [PropertyValueType(typeof(SeoMetadata))]
  [PropertyValueCache(PropertyCacheValue.All, PropertyCacheLevel.Content)]
  public class SeoMetadataEditorPVC : PropertyValueConverterBase
  {
    public override bool IsConverter(PublishedPropertyType propertyType)
    {
      return propertyType.PropertyEditorAlias != null && propertyType.PropertyEditorAlias.Equals("Company.SeoMetadataEditor");
    }

    public override object ConvertDataToSource(PublishedPropertyType propertyType, object source, bool preview)
    {
      if (source == null)
        return null;

      if (string.IsNullOrWhiteSpace(source.ToString()))
        return null;

      try
      {
        var metadata = JsonConvert.DeserializeObject<SeoMetadata>(source.ToString());
        return metadata;
      }
      catch (Exception ex)
      {
        LogHelper.Warn<SeoMetadataEditorPVC>(string.Format($"Unable to deserialize SeoMetadata. Details: {ex.GetType().Name} - {ex.Message}"));
        return null;
      }
    }
  }
}
```

As a result of this, I'm now able to pick up the Metadata field values as follows (using the Page Title property as the example):
```
@Model.Content.Metadata.Title
```

## Conclusion
I was a little daunted at the prospect of creating a new plugin, given that I've only been working on Umbraco for a short time now, and I had little to no experience of Angular too (more recent versions of Umbraco use it for plugins etc.).
However, thanks to the Umbraco tutorial and Ryan Lewis' plugin, I have been able to create something really quickly that's really simple too.