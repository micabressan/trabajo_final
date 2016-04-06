import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Rename {
    public static void main(String args[]) {
        if (args.length == 1) {
            File path = new File(args[0].toString());
            if (path.isDirectory()) {
                String[] array = path.list();
                File[] pathFiles = path.listFiles();
                String name = "WYC";
                String extension = ".png";
                if (pathFiles.length == 0) {
                    System.out.println("Directory is empty.");
                    return;
                }
                for (int i = 0; i < array.length; i++) {
                    Date date = new Date(pathFiles[i].lastModified());
                    SimpleDateFormat sdf = new SimpleDateFormat("MM:dd:yyyy HH-mm-ss");
                    File oldPath = new File(path, array[i]);
                    File newPath = new File(path, (name + sdf.format(date) + extension));
                    if (!array[i].startsWith(name) && array[i].endsWith(extension)) {
                        System.out.println("Renaming " + array[i] + " to " + name + sdf.format(date) + extension);
                        oldPath.renameTo(newPath);
                    }
                }
            } else {
                System.out.println("Path specified is not a directory.");
            }
        } else {
            System.out.println("Please specify a directory.");
        }
    }
}