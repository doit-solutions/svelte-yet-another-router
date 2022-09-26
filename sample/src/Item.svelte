<script>
    import { Redirect } from 'svelte-yet-another-router';

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

<h3>Item {id}</h3>
<p>This is the item with id {id}.</p>
{#if !done}
    {#if !processing}
        <button on:click={onProcessClick}>Process item</button>
    {:else}
        <p>Processing...</p>
    {/if}
{:else}
    <Redirect to="/" />
{/if}
