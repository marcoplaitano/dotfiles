#!/bin/bash


file=$1
name=$2


# Header comments.
echo $"\
/**
 * @file $(basename "$file")
 * @author Marco Plaitano
 * @date $(date +'%d %b %Y')
 */
" > "$file"



# Files that requires the main() function.
if [[ $name == Main* ]]; then
    echo $"\
public class $name {
    public static void main(String args[]) {

    }
}" >> "$file"



# Test files.
elif [[ $name == *Test* ]]; then
    echo $"\
import org.junit.*;

import static org.junit.Assert.*;

public class $name {

    @BeforeClass
    public static void setUp() {

    }

    @AfterClass
    public static void tearDown() {

    }
}
" > "$file"



# Exception files.
elif [[ $name == *Exception* ]]; then
    echo $"\
public class $name extends RuntimeException {
    public $name() {

    }

    public $name(String msg) {
        super(msg);
    }
}" >> "$file"



# GUI app files.
elif [[ $name == *App* ]]; then
    echo $"\
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

/**
 * @file $(basename "$file")
 * @author Marco Plaitano
 * @date $(date +'%d %b %Y')
 */

public class $name extends Application {
    public static void main(String args[]) {
        launch(args);
    }

    @Override
    public void start(Stage stage) throws Exception {
        Parent root = FXMLLoader.load(getClass().getResource(\"ui.fxml\"));
        Scene scene = new Scene(root);
        stage.setScene(scene);
        stage.setTitle(\"$name\");
        stage.show();
    }
}" > "$file"



# Every other Java file is treated as a class.
else
    echo $"public class $name {

}" >> "$file"
fi
