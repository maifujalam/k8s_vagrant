def dns_resolution(cache_size, cache_time, server_time, urls):
    cache = {}  # Dictionary to store URL-IP mappings
    time_taken = []  # List to store the time taken for each URL

    for url in urls:
        if url in cache:
            # If URL is in the cache, fetch from cache and update time_taken
            time_taken.append(cache_time)
            cache[url] = 0  # Reset the time in cache for this URL
        else:
            # If URL is not in cache, fetch from server and update cache
            time_taken.append(server_time)
            if len(cache) == cache_size:
                # Remove the least recently used URL from cache
                lru_url = min(cache, key=cache.get)
                del cache[lru_url]
            cache[url] = 0  # Add the new URL to cache with time 0

        # Increment time for all URLs in the cache
        for key in cache:
            cache[key] += 1

    return time_taken

# Example usage
cache_size = 3
cache_time = 2
server_time = 5
urls = ["http://www.hackerrank.com", "http://www.google.com", "http://www.yahoo.com", "http://www.gmail.com", "http://www.yahoo.com", "http://www.hackerrank.com", "http://www.gmail.com"]
result = dns_resolution(cache_size, cache_time, server_time, urls)
print(result)
