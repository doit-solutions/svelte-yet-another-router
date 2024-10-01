<script>
    import "./App.scss";

    import {
        activePropName,
        activePropValue,
        Route,
        pathBase,
    } from "svelte-yet-another-router";

    import Menu from "./Menu.svelte";
    import Item from "./Item.svelte";
    import About from "./About.svelte";

    $pathBase = "/";
    $activePropName = "aria-current";
    $activePropValue = "page";
</script>

<Menu />
<main class="container">
    <hgroup>
        <h1>Yet another Svelte router</h1>
        <p>Now with Svelte 4 support</p>
    </hgroup>

    <Route path="/">
        <p>Welcome to the home screen!</p>
        <p>
            Svelte 4 support is great when it arrives just in time for the
            Svelte 5 release 👍. And don't forget that Svelte 3 is still
            supported!
        </p>
    </Route>
    <Route
        path="/items/:id"
        let:params
        on:match={({ detail }) => console.log({ params: detail })}
    >
        <Item {...params} />
    </Route>
    <Route path="/about/">
        <About />
    </Route>
</main>
