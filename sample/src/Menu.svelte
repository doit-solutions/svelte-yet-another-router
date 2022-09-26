<script>
    import { Link } from 'svelte-yet-another-router';
</script>

<style>
    :global(ul.horz-menu) {
        list-style-type: none;
        margin: 0px;
        padding: 0px;
        background-color: #ddd;
        overflow: hidden;
    }

    :global(ul.horz-menu li) {
        float: left;
    }

    :global(ul.horz-menu li a) {
        display: block;
        padding: 8px;
        color: black;
        text-decoration: none;
    }

    :global(ul.horz-menu li a:hover) {
        background-color: #bbb;
    }

    :global(ul.horz-menu li a.is-active) {
        color: white;
        background-color: #888;
    }
</style>

<ul class="horz-menu">
    <li><Link href="/">Home</Link></li>
    <li><Link href="/items/1">Item 1</Link></li>
    <li><Link href="/items/2">Item 2</Link></li>
    <li><Link href="/about">About</Link></li>
</ul>
