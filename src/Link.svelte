<script context="module">
    import { writable } from 'svelte/store';

    import { pathBase } from './Route.svelte';

    export const activeClassName = writable('is-active');
    export const forceReload = writable(false);
</script>

<script>
    import { location, push } from './Route.svelte';

    export let href;
    export let exact = true;
    $: className = $$restProps['class'] || '';
    $: ariaProps = Object.getOwnPropertyNames($$restProps)
        .filter(p => p.startsWith('aria-'))
        .reduce((c, p) => { c[p] = $$restProps[p]; return c; }, {});
    $: dataProps = Object.getOwnPropertyNames($$restProps)
        .filter(p => p.startsWith('data-'))
        .reduce((c, p) => { c[p] = $$restProps[p]; return c; }, {});

    $: tempHref = href.startsWith('/') ? `${$pathBase}${href}` : href;
    $: completeHref = !tempHref.endsWith('/') ? tempHref : tempHref.substring(0, tempHref.length - 1);
    $: pathname = !$location.pathname.endsWith('/') ? $location.pathname : $location.pathname.substring(0, $location.pathname.length - 1);
    $: cls = (exact && pathname === completeHref) || (!exact && pathname.indexOf(completeHref) === 0) ? $activeClassName : '';

    function handleClick(e) {
        if (!$forceReload) {
            e.preventDefault();
            $push(href);
        }
    }
</script>

<a class={(className + ' ' + cls).trim()} href={completeHref} {...ariaProps} {...dataProps} on:click={handleClick} on:click>
    <slot></slot>
</a>
