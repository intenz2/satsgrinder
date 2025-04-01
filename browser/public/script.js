async function search(type) {
    const query = document.getElementById('searchInput').value;
    if (!query) return alert("Please enter a search term!");

    const endpoint = type === 'images' ? '/search/images' : '/search';

    const response = await fetch(endpoint, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ query })
    });

    const data = await response.json();
    const resultsList = document.getElementById('results');
    resultsList.innerHTML = "";

    if (data.results.length === 0) {
        resultsList.innerHTML = "<li>No results found.</li>";
    } else {
        data.results.forEach(item => {
            const li = document.createElement('li');

            if (type === 'images') {
                const img = document.createElement('img');
                img.src = item;
                img.alt = "Image result";
                li.appendChild(img);
            } else {
                const a = document.createElement('a');
                a.href = item;
                a.textContent = item;
                a.target = "_blank";
                li.appendChild(a);
            }

            resultsList.appendChild(li);
        });
    }
}
