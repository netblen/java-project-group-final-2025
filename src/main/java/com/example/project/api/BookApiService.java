package com.example.project.api;

import com.example.project.model.Book;
import org.json.JSONObject;
import org.json.JSONArray;

import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;

public class BookApiService {

    public static Book fetchBookFromGoogle(String title) throws Exception {
        String apiUrl = "https://www.googleapis.com/books/v1/volumes?q=" + title.replace(" ", "+");

        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.connect();

        InputStream input = conn.getInputStream();
        Scanner scanner = new Scanner(input).useDelimiter("\\A");
        String json = scanner.hasNext() ? scanner.next() : "";

        JSONObject obj = new JSONObject(json);
        JSONObject info = obj.getJSONArray("items").getJSONObject(0).getJSONObject("volumeInfo");

        String fetchedTitle = info.getString("title");
        String author = info.getJSONArray("authors").getString(0);
        String genre = info.has("categories") ? info.getJSONArray("categories").getString(0) : "General";

        return new Book(999, fetchedTitle, author, genre, 0.0, 0, true);
    }
}
