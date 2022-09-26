# svelte-yet-another-router

## Getting started
This Svelte router has a simple API with a total of only five components. The two most important ones are the `Route` and the `Link` components. The purpose of the `Route` component is to conditionally render its children based on the current location. The purpose of the `Link` component is to provide clickable links which doesn't reload the entire page from the server but instead casues Svelte to update the application and it's `Route` components based on the `Link`'s target.

    <script>
        import { Link, Route, Switch, pathBase, push } from 'svelte-yet-another-router';

        // If your app is published in a subfolder, you can set the path base to make all
        // <Route>s, <Link>s and <Redirect>s automatically work with you path base.
        pathBase.set('/base');
    </script>

    <h1>My app!</h1>
    <Route path="/">
        <p>This is the home page. Why don't you visit <Link href="/page1">another page</Link>? Or <Link href="page2">yet another</Link>?

        <Link href="/page3">This link</Link> will take you right back to the start.
    </Route>
    <Switch>
        <Route path="/page1">
            <p>Another page!</p>
        </Route>
        <Route path="/page2">
            <p>Yet another page!</p>
        </Route>
        <!-- The $push store allows you to push a URI (and corresponding state to the browser history -->
        <Route path="/page3" on:match={() => $push('/')}>
            <p>Going home!</p>
        </Route>
        <Route path="/" exact={false}>
            <p>404: Unknown page!</p>
        </Route>
    </Switch>

Additionally, the `Redirect` and `ExternalRedirect` components are available, which will redirect the user to the provided target whenever it is rendered. The difference is that the `Redirect` component will only redirect within the same application by triggering Svelte to update the rendering while `ExternalRedirect` will simply change the browser's location to whichever URL is provided.

Finally, a `Switch` component is available. Among the first level of `Route` components contained within a `Switch` component, only the first one with a matching path is
rendered. This, among other things, allows for the construction of "catch all" routes for handling unknown paths.
