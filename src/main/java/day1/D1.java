package day1;

import helper.DownloadData;

import java.io.IOException;

public class D1 {
    public static void main(String[] args) throws IOException, InterruptedException {
        DownloadData downloadData = new DownloadData();
        downloadData.downloadFile("test", 2016, 1);
    }
}
