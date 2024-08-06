<script>
    import { Link } from "svelte-yet-another-router";
</script>

<header class="container">
    <nav>
        <ul>
            <li><code>svelte-yet-another-router</code></li>
        </ul>
        <ul>
            <li><Link href="/">Home</Link></li>
            <li><Link href="/items/1">Item 1</Link></li>
            <li><Link href="/items/2">Item 2</Link></li>
            <li><Link href="/about">About</Link></li>
        </ul>
    </nav>
</header>
