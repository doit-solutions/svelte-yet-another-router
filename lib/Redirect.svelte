<script>
    import { location } from "./Route.svelte";

    export let to;
    location.push(to);
</script>
