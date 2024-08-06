<script>
    import { Redirect } from "svelte-yet-another-router";

    export let id;

    let processing = false;
    let done = false;

    function onProcessClick() {
        processing = true;
        window.setTimeout(() => {
            processing = false;
            done = true;
        }, 1000);
    }
</script>

<h2>Item {id}</h2>
<p>This is the item with id {id}.</p>
{#if !done}
    <button
        on:click={onProcessClick}
        disabled={processing}
        aria-busy={processing}
    >
        Process item
    </button>
{:else}
    <Redirect to="/" />
{/if}
