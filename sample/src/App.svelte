<script>
    import { Route, pathBase } from 'svelte-yet-another-router';

    import Menu from './Menu.svelte';
    import Item from './Item.svelte';
    import About from './About.svelte';

    pathBase.set('/');
</script>

<style>
    :global(html) {
        font-family: sans-serif;
    }
</style>

<h1>Yet another Svelte router</h1>

<Menu />

<Route path="/">
    <p>Welcome to the home screen!</p>
</Route>
<Route path="/items/:id" let:params on:match={e => console.log({ params: e.detail })}>
    <Item {...params} />
</Route>
<Route path="/about/">
    <About />
</Route>
