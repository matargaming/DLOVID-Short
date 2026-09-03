package com.dlovid.short;

import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;
import androidx.viewpager2.widget.ViewPager2;
import com.google.firebase.firestore.FirebaseFirestore;
import com.google.firebase.firestore.Query;
import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {

    private ViewPager2 viewPagerVideo;
    private FirebaseFirestore db;
    private List<String> videoUrls = new ArrayList<>();
    private VideoAdapter adapter; // Adapter buat nampilin video

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // 1. Inisialisasi
        viewPagerVideo = findViewById(R.id.viewPagerVideo);
        db = FirebaseFirestore.getInstance();

        // 2. Ambil data video dari Firebase (collection "videos")
        db.collection("videos")
                .orderBy("timestamp", Query.Direction.DESCENDING)
                .addSnapshotListener((value, error) -> {
                    if (value != null) {
                        videoUrls.clear();
                        for (var doc : value.getDocuments()) {
                            String url = doc.getString("videoUrl");
                            if (url != null) videoUrls.add(url);
                        }
                        // 3. Pasang ke adapter
                        adapter = new VideoAdapter(this, videoUrls);
                        viewPagerVideo.setAdapter(adapter);
                    }
                });

        // 4. Biar scroll vertical kayak TikTok (sudah di XML, ini tambahan)
        viewPagerVideo.setOrientation(ViewPager2.ORIENTATION_VERTICAL);
    }
}
