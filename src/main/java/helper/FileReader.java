package helper;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class FileReader {

    public String readFile (String filePath) {
        Path fPath = Paths.get(filePath);
        String content = null;
        try {
            content = Files.readString(fPath);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return content;
    }


}
