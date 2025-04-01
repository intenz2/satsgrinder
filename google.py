import requests
from bs4 import BeautifulSoup
import urllib.parse

def bing_search(query):
    url = f"https://www.bing.com/search?q={urllib.parse.quote(query)}"
    headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36"}
    response = requests.get(url, headers=headers)
    
    if response.status_code != 200:
        print("Failed to retrieve search results")
        return []
    
    soup = BeautifulSoup(response.text, "html.parser")
    links = []
    
    for result in soup.select("li.b_algo a"):
        href = result.get("href")
        if href and href.startswith("http"):
            links.append(href)
    
    return links

if __name__ == "__main__":
    search_query = "youtube"
    results = bing_search(search_query)
    
    print("Search results:")
    for link in results:
        print(link)
