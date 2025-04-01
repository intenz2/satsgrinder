const express = require('express');
const axios = require('axios');
const cheerio = require('cheerio');
const path = require('path');

const app = express();
const PORT = 3000;

app.use(express.static('public'));
app.use(express.json());

// Funktion zum Scrapen von normalen Suchergebnissen
async function bingSearch(query) {
    const url = `https://www.bing.com/search?q=${encodeURIComponent(query)}`;
    const headers = { "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36" };
    
    try {
        const response = await axios.get(url, { headers });
        const $ = cheerio.load(response.data);
        let links = [];
        
        $('li.b_algo a').each((i, elem) => {
            const href = $(elem).attr('href');
            if (href && href.startsWith('http')) {
                links.push(href);
            }
        });

        return links;
    } catch (error) {
        console.error("Failed to retrieve search results", error);
        return [];
    }
}

// Funktion zum Scrapen von Bing-Bildern
async function bingImageSearch(query) {
    const url = `https://www.bing.com/images/search?q=${encodeURIComponent(query)}`;
    const headers = { "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36" };
    
    try {
        const response = await axios.get(url, { headers });
        const $ = cheerio.load(response.data);
        let images = [];
        
        $('a.iusc').each((i, elem) => {
            let metadata = $(elem).attr('m');
            if (metadata) {
                let imageUrl = metadata.match(/"murl":"(.*?)"/);
                if (imageUrl) {
                    images.push(imageUrl[1]);
                }
            }
        });

        return images;
    } catch (error) {
        console.error("Failed to retrieve image results", error);
        return [];
    }
}

// API-Route für Textsuche
app.post('/search', async (req, res) => {
    const { query } = req.body;
    if (!query) return res.status(400).json({ error: "Query is required" });
    
    const results = await bingSearch(query);
    res.json({ results });
});

// API-Route für Bildersuche
app.post('/search/images', async (req, res) => {
    const { query } = req.body;
    if (!query) return res.status(400).json({ error: "Query is required" });
    
    const results = await bingImageSearch(query);
    res.json({ results });
});

app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
});
