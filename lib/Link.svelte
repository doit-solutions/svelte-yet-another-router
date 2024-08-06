<script context="module">
    import { writable } from "svelte/store";

    import { pathBase } from "./Route.svelte";

    export const activePropName = writable("class");
    export const activePropValue = writable("is-active");
    export const forceReload = writable(false);
</script>

<script>
    import { location, push } from "./Route.svelte";

    export let href;
    export let exact = true;
    $: className = $$props["class"] || "";
    $: ariaProps = Object.getOwnPropertyNames($$props)
        .filter((p) => p.startsWith("aria-"))
        .reduce((c, p) => {
            c[p] = $$props[p];
            return c;
        }, {});
    $: dataProps = Object.getOwnPropertyNames($$props)
        .filter((p) => p.startsWith("data-"))
        .reduce((c, p) => {
            c[p] = $$props[p];
            return c;
        }, {});

    $: tempHref = href.startsWith("/") ? `${$pathBase}${href}` : href;
    $: completeHref =
        (!tempHref.endsWith("/")
            ? tempHref
            : tempHref.substring(0, tempHref.length - 1)) || "/";
    $: pathname =
        (!$location.pathname.endsWith("/")
            ? $location.pathname
            : $location.pathname.substring(0, $location.pathname.length - 1)) ||
        "/";
    $: activeProps =
        (exact && pathname === completeHref) ||
        (!exact && pathname.indexOf(completeHref) === 0)
            ? [$activePropName].reduce((c, p) => {
                  let c2 = { ...c };
                  c2[p] = `${$activePropValue} ${className}`.trimEnd();
                  return c2;
              }, {})
            : {};

    function handleClick(e) {
        if (!$forceReload) {
            e.preventDefault();
            $push(href);
        }
    }
</script>

<a
    class={className}
    href={completeHref}
    {...ariaProps}
    {...dataProps}
    {...activeProps}
    on:click={handleClick}
    on:click
>
    <slot></slot>
</a>
