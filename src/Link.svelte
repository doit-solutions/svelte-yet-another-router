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

    $: completeHref = href.startsWith('/') ? `${$pathBase}{href}` : href;
    $: cls = (exact && $location.pathname === href) || (!exact && $location.pathname.indexOf(href) === 0) ? $activeClassName : '';

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
