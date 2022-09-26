<script>
    import { push } from './Route.svelte';

    export let to;
    $push(to);
</script>
