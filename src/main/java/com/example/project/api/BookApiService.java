package com.example.project.api;

import com.example.project.model.Book;
import org.json.JSONArray;
import org.json.JSONObject;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
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

        List<String> genres = new ArrayList<>();
        if (info.has("categories")) {
            JSONArray categories = info.getJSONArray("categories");
            for (int i = 0; i < categories.length(); i++) {
                genres.add(categories.getString(i));
            }
        } else {
            genres.add("General");
        }

        int id = (int) (Math.random() * 100000);
        return new Book(id, fetchedTitle, author, 0.0, 0, true, genres);


    }
}
