package helper;

import java.io.File;
import java.io.FileWriter;

public class FWriter {
    public void fWriter (String contents, String dir, String filename) {
        File file = new File(dir, filename+".txt");
        String path = dir + filename + ".txt";
        if (file.exists()) {
            System.out.println("File aready exists, skipping");
        } else {
            try (FileWriter fileWriter = new FileWriter(path)){
                fileWriter.write(contents);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
