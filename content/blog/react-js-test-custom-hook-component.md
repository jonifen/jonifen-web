---
type: "blog"
title: "How to test a custom React hook component"
description: ""
date: 2020-12-28T10:20:47Z
author: "Jon"
tags: ["programming", "javascript", "react", "testing"]
---
As part of my GameBrowser side-project, I'm at the stage where I wanted to start improving the UI a bit. This included needing to define a way of filtering the servers in the list, because they're all saved together at the moment. As a first attempt, I opted for a simple Dropdown control and decided to make it generic using a custom React Hook.

The result was the creation of `useDropdown`.

```js
// useDropdown.js
import React, { useState } from "react";

const useDropdown = (label, defaultSelected, options) => {
  const [selected, setSelected] = useState(defaultSelected);
  const id = `use-dropdown-${label.replace(" ", "").toLowerCase()}`;

  const onChangeEvent = (event) => {
    setSelected(event.target.value);
  }

  const Dropdown = () => (
    <label data-testid={`${id}-label`} htmlFor="{id}">
      {label}
      <select data-testid={id} id={id} value={selected} onChange={onChangeEvent} onBlur={onChangeEvent} disabled={!options.length}>
        <option>All</option>
        {
          options.map(option => (
            <option key={option} value={option}>{option}</option>
          ))
        }
      </select>
    </label>
  );

  return [selected, Dropdown];
}

export default useDropdown;
```

And to use this new component, I created a filter panel component too:

```js
import React from "react";
import useDropdown from "./use-dropdown.jsx";

const FilterPanel = () => {
  const games = ["Quake 3 Arena", "Unreal Tournament 99"];
  const [game, GameDropdown] = useDropdown("Game", "All", games);

  const onClickFilterEvent = (event) => {
    console.log(`User clicked with the game set to '${game}'.`);
  };

  return (
    <React.Fragment>
      <span>Filter: </span>
      <GameDropdown />
      <button onClick={onClickFilterEvent}>Filter</button>
    </React.Fragment>
  );
}

export default FilterPanel;
```

So to explain what I've done, I just created a rough array of games, and then consumed `useDropdown`, passing in a label, the default value and the games array which will be the options in the dropdown.

Now I've done this, the next question is how it can be tested. The component can't be mounted like any other component and as such we will need to approach it differently, and this is how I did it:

```js
import React from "react";
import {render, cleanup, fireEvent } from "@testing-library/react";
import { renderHook } from "@testing-library/react-hooks";
import useDropdown from "../../components/use-dropdown.jsx";

afterEach(cleanup);

describe("<useDropdown />", () => {
  it("should render without crashing", () => {
    const { result } = renderHook(() => useDropdown("", "", []));

    expect(result).toBeDefined();
  });

  it("should render a disabled dropdown with only one item included when no options provided", () => {
    const { result } = renderHook(() => useDropdown("Test", "", []));
    const { getByTestId } = render(result.current[1]());
    const dropdown = getByTestId("use-dropdown-test");

    expect(dropdown.disabled).toEqual(true);
  });

  it("should render a dropdown with a second item of 'Interesting' when provided as an option", () => {
    const { result } = renderHook(() => useDropdown("Test", "", ["Interesting"]));
    const { getByTestId } = render(result.current[1]());
    const dropdown = getByTestId("use-dropdown-test");

    expect(dropdown.children[1].textContent).toEqual("Interesting");
  });

  it("should change dropdown selected value when changed to 'Interesting'", () => {
    // Arrange
    const { result } = renderHook(() => useDropdown("Test", "", ["Interesting"]));
    const { getByTestId } = render(result.current[1]());
    const dropdown = getByTestId("use-dropdown-test");

    // Act
    fireEvent.change(dropdown, { target: { value: "Interesting" } });

    // Assert
    expect(result.current[0]).toEqual("Interesting");
  });
});
```

As part of the Testing Library suite, there is the `react-hooks` package, which will allow us to render a hook component. This allows us to get the rendered component that we can assert things upon. We're also able to interact with the component using the `fireEvent` function (part of the React Testing Library).

Hopefully this helps you get started with testing your hook components.
