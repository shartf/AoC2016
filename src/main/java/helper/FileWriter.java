package helper;

import java.io.File;

public class FileWriter {
    public void fileWriter (String contents, String dir, String filename) {
        File file = new File(dir, filename+".txt");

    }
}
