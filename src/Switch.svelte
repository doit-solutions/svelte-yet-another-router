<script context="module">
    export const ContextKey = 'switchSwitched';
</script>

<script>
    import { afterUpdate, setContext } from 'svelte';
    import { writable } from 'svelte/store';

    const { subscribe, set } = writable(undefined);
    const switched = {
        subscribe,
        activateSwitch: id => set(id)
    };

    setContext(ContextKey, switched);
</script>

<slot />
