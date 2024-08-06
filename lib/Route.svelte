<script context="module">
    import { readable, writable, get } from "svelte/store";

    export const pathBase = (() => {
        const { subscribe, set } = writable("");
        return {
            set: (pathBase) => {
                if (!pathBase.startsWith("/")) {
                    pathBase = `/${pathBase}`;
                }
                if (pathBase.endsWith("/")) {
                    pathBase = pathBase.substring(0, pathBase.length - 1);
                }
                set(pathBase);
            },
            subscribe,
        };
    })();

    let locationSetter = null;
    export const location = readable(window.location, (set) => {
        locationSetter = set;
        let eventListener = (e) => {
            set(window.location);
        };
        window.addEventListener("popstate", eventListener);
        return () => window.removeEventListener("popstate", eventListener);
    });
    export const push = readable(
        function (href, state = null) {
            const completeHref = href.startsWith("/")
                ? `${get(pathBase)}${href}`
                : href;
            window.history.pushState(state, null, completeHref);
            locationSetter(window.location);
        },
        (set) => {},
    );
    let count = 0;
</script>

<script>
    import { getContext, setContext, createEventDispatcher } from "svelte";
    import { Path } from "path-parser";

    import { ContextKey } from "./Switch.svelte";

    const dispatch = createEventDispatcher();

    export let path;
    export let exact = true;
    export let onMatch = undefined;
    const id = count;
    count += 1;

    const switched = getContext(ContextKey);

    $: tempPath = `${$pathBase}${path.startsWith("/") ? path : `/${path}`}`;
    $: completePath = !tempPath.endsWith("/")
        ? tempPath
        : tempPath.substring(0, tempPath.length - 1);
    $: pathname = !$location.pathname.endsWith("/")
        ? $location.pathname
        : $location.pathname.substring(0, $location.pathname.length - 1);
    $: p = Path.createPath(completePath || "/");
    $: match = exact ? p.test(pathname || "/") : p.partialTest(pathname || "/");
    $: render =
        match !== null &&
        (!switched || $switched === undefined || $switched === id);
    $: queryParams = {};
    $: if (render) {
        if (switched) {
            switched.activateSwitch(id);
        }
        const p = new URLSearchParams($location.search);
        queryParams = Array.from(p.keys()).reduce((c, k) => {
            let c2 = { ...c };
            c2[k] = p.get(k);
            return c2;
        }, {});
        dispatch("match", { ...match, ...queryParams });
        if (onMatch !== undefined) {
            onMatch({ ...match, ...queryParams });
        }

        setContext(ContextKey, undefined);
    } else {
        if (switched && $switched === id) {
            switched.activateSwitch(undefined);
        }
    }
    $: params = { ...match, ...queryParams };
</script>

{#if render}
    <slot {params}></slot>
{/if}
