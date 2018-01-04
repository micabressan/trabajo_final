<?xml version="1.0" encoding="UTF-8"?>

<?import javafx.geometry.Insets?>
<?import javafx.scene.control.Button?>
<?import javafx.scene.control.ComboBox?>
<?import javafx.scene.control.Label?>
<?import javafx.scene.control.ListView?>
<?import javafx.scene.control.Menu?>
<?import javafx.scene.control.MenuBar?>
<?import javafx.scene.control.MenuItem?>
<?import javafx.scene.control.TextField?>
<?import javafx.scene.effect.InnerShadow?>
<?import javafx.scene.layout.AnchorPane?>
<?import javafx.scene.layout.ColumnConstraints?>
<?import javafx.scene.layout.GridPane?>
<?import javafx.scene.layout.RowConstraints?>
<?import javafx.scene.web.WebView?>

<AnchorPane minHeight="600.0" minWidth="1000.0" xmlns="http://javafx.com/javafx/9.0.1" xmlns:fx="http://javafx.com/fxml/1" fx:controller="application.Controller">
   <children>
      <GridPane minHeight="600.0" minWidth="1000.0">
        <columnConstraints>
          <ColumnConstraints hgrow="SOMETIMES" prefWidth="100.0" />
          <ColumnConstraints hgrow="SOMETIMES" minWidth="10.0" prefWidth="100.0" />
        </columnConstraints>
        <rowConstraints>
          <RowConstraints maxHeight="30.0" minHeight="30.0" prefHeight="30.0" vgrow="SOMETIMES" />
          <RowConstraints maxHeight="30.0" minHeight="30.0" prefHeight="30.0" vgrow="SOMETIMES" />
          <RowConstraints vgrow="SOMETIMES" />
            <RowConstraints maxHeight="30.0" minHeight="30.0" prefHeight="30.0" vgrow="SOMETIMES" />
        </rowConstraints>
         <children>
            <GridPane style="-fx-hgap: 5;" GridPane.columnIndex="1" GridPane.rowIndex="1">
              <columnConstraints>
                <ColumnConstraints hgrow="SOMETIMES" maxWidth="75.0" minWidth="75.0" prefWidth="75.0" />
                <ColumnConstraints hgrow="SOMETIMES" minWidth="10.0" prefWidth="100.0" />
                  <ColumnConstraints hgrow="SOMETIMES" maxWidth="75.0" minWidth="75.0" prefWidth="75.0" />
              </columnConstraints>
              <rowConstraints>
                <RowConstraints minHeight="10.0" prefHeight="30.0" vgrow="SOMETIMES" />
              </rowConstraints>
               <children>
                  <Label alignment="CENTER" prefWidth="75.0" text="Suchbegriff" />
                  <TextField fx:id="searchInput" GridPane.columnIndex="1" />
                  <Button fx:id="searchBtn" maxWidth="70.0" minWidth="70.0" mnemonicParsing="false" prefWidth="70.0" text="suchen" GridPane.columnIndex="2">
                     <GridPane.margin>
                        <Insets right="5.0" />
                     </GridPane.margin>
                  </Button>
               </children>
            </GridPane>
            <MenuBar GridPane.columnSpan="2">
              <menus>
                <Menu mnemonicParsing="false" text="?">
                  <items>
                    <MenuItem mnemonicParsing="false" text="Über dieses Programm" />
                  </items>
                </Menu>
              </menus>
            </MenuBar>
            <GridPane alignment="BOTTOM_CENTER" maxHeight="30.0" minHeight="30.0" prefHeight="30.0" GridPane.columnIndex="1" GridPane.rowIndex="3" GridPane.valignment="BOTTOM">
              <columnConstraints>
                <ColumnConstraints hgrow="SOMETIMES" minWidth="10.0" prefWidth="100.0" />
                <ColumnConstraints hgrow="SOMETIMES" minWidth="10.0" prefWidth="100.0" />
              </columnConstraints>
              <rowConstraints>
                <RowConstraints minHeight="10.0" prefHeight="30.0" vgrow="SOMETIMES" />
              </rowConstraints>
               <children>
                  <GridPane>
                     <columnConstraints>
                        <ColumnConstraints hgrow="SOMETIMES" maxWidth="-Infinity" minWidth="10.0" prefWidth="100.0" />
                        <ColumnConstraints hgrow="SOMETIMES" minWidth="10.0" prefWidth="100.0" />
                     </columnConstraints>
                     <rowConstraints>
                        <RowConstraints minHeight="10.0" prefHeight="30.0" vgrow="SOMETIMES" />
                     </rowConstraints>
                     <children>
                        <Label text="Letzter Bearbeiter: " />
                        <Label fx:id="authorName" text="n.B." GridPane.columnIndex="1" />
                     </children>
                  </GridPane>
                  <GridPane GridPane.columnIndex="1">
                     <columnConstraints>
                        <ColumnConstraints hgrow="SOMETIMES" maxWidth="-Infinity" minWidth="10.0" prefWidth="100.0" />
                        <ColumnConstraints hgrow="SOMETIMES" minWidth="10.0" prefWidth="100.0" />
                     </columnConstraints>
                     <rowConstraints>
                        <RowConstraints minHeight="10.0" prefHeight="30.0" vgrow="SOMETIMES" />
                     </rowConstraints>
                     <children>
                        <Label text="Letzte Änderung: " />
                        <Label fx:id="timeStamp" text="n.B." GridPane.columnIndex="1" />
                     </children>
                  </GridPane>
               </children>
            </GridPane>
            <WebView fx:id="webView" minHeight="-1.0" minWidth="-1.0" prefHeight="-1.0" prefWidth="-1.0" GridPane.columnIndex="1" GridPane.rowIndex="2">
               <effect>
                  <InnerShadow color="#00000054" />
               </effect>
            </WebView>
            <GridPane GridPane.rowIndex="1">
              <columnConstraints>
                <ColumnConstraints hgrow="SOMETIMES" minWidth="10.0" prefWidth="100.0" />
                <ColumnConstraints hgrow="SOMETIMES" minWidth="10.0" prefWidth="100.0" />
              </columnConstraints>
              <rowConstraints>
                <RowConstraints minHeight="10.0" prefHeight="30.0" vgrow="SOMETIMES" />
              </rowConstraints>
               <children>
                  <GridPane>
                    <columnConstraints>
                      <ColumnConstraints hgrow="SOMETIMES" maxWidth="-Infinity" />
                      <ColumnConstraints hgrow="SOMETIMES" minWidth="100.0" prefWidth="100.0" />
                        <ColumnConstraints hgrow="SOMETIMES" maxWidth="-Infinity" />
                    </columnConstraints>
                    <rowConstraints>
                      <RowConstraints minHeight="10.0" prefHeight="30.0" vgrow="SOMETIMES" />
                    </rowConstraints>
                     <children>
                        <Button fx:id="btnBack" mnemonicParsing="false" text="zurück">
                           <GridPane.margin>
                              <Insets left="5.0" right="5.0" />
                           </GridPane.margin>
                        </Button>
                        <Button fx:id="btnForwrd" mnemonicParsing="false" text="vor" GridPane.columnIndex="2">
                           <GridPane.margin>
                              <Insets left="5.0" right="5.0" />
                           </GridPane.margin>
                        </Button>
                        <ComboBox prefWidth="150.0" GridPane.columnIndex="1" />
                     </children>
                  </GridPane>
                  <GridPane GridPane.columnIndex="1">
                    <columnConstraints>
                      <ColumnConstraints hgrow="SOMETIMES" minWidth="10.0" prefWidth="100.0" />
                      <ColumnConstraints hgrow="SOMETIMES" minWidth="10.0" prefWidth="100.0" />
                        <ColumnConstraints hgrow="SOMETIMES" minWidth="10.0" prefWidth="100.0" />
                    </columnConstraints>
                    <rowConstraints>
                      <RowConstraints minHeight="10.0" prefHeight="30.0" vgrow="SOMETIMES" />
                    </rowConstraints>
                     <children>
                        <Button fx:id="btnAdd" mnemonicParsing="false" text="hinzufügen">
                           <GridPane.margin>
                              <Insets left="5.0" />
                           </GridPane.margin>
                        </Button>
                        <Button fx:id="btnSort" mnemonicParsing="false" text="sortieren" GridPane.columnIndex="1" GridPane.halignment="RIGHT">
                           <GridPane.margin>
                              <Insets left="5.0" right="5.0" />
                           </GridPane.margin>
                        </Button>
                        <Button fx:id="btnDelete" disable="true" layoutX="10.0" layoutY="13.0" mnemonicParsing="false" text="löschen" GridPane.columnIndex="2" GridPane.halignment="RIGHT">
                           <GridPane.margin>
                              <Insets left="5.0" right="5.0" />
                           </GridPane.margin>
                        </Button>
                     </children>
                  </GridPane>
               </children>
            </GridPane>
            <GridPane GridPane.rowIndex="2">
              <columnConstraints>
                <ColumnConstraints hgrow="SOMETIMES" minWidth="10.0" prefWidth="100.0" />
                <ColumnConstraints hgrow="SOMETIMES" minWidth="10.0" prefWidth="100.0" />
              </columnConstraints>
              <rowConstraints>
                <RowConstraints maxHeight="30.0" minHeight="30.0" prefHeight="30.0" vgrow="SOMETIMES" />
                <RowConstraints minHeight="10.0" prefHeight="30.0" vgrow="SOMETIMES" />
                <RowConstraints maxHeight="30.0" minHeight="30.0" prefHeight="30.0" vgrow="SOMETIMES" />
              </rowConstraints>
               <children>
                  <Button fx:id="synSearch" mnemonicParsing="false" text="Synonym Suche" GridPane.rowIndex="2">
                     <GridPane.margin>
                        <Insets left="5.0" right="5.0" />
                     </GridPane.margin>
                  </Button>
                  <Label style="-fx-font-weight: bold;" text="Synonyme: ">
                     <opaqueInsets>
                        <Insets />
                     </opaqueInsets>
                     <padding>
                        <Insets left="10.0" right="5.0" />
                     </padding>
                  </Label>
                  <Label style="-fx-font-weight: bold;" text="Medien: " GridPane.columnIndex="1">
                     <padding>
                        <Insets left="5.0" right="5.0" />
                     </padding>
                  </Label>
                  <ListView prefHeight="200.0" prefWidth="200.0" GridPane.rowIndex="1">
                     <GridPane.margin>
                        <Insets left="5.0" right="5.0" />
                     </GridPane.margin>
                  </ListView>
                  <ListView prefHeight="200.0" prefWidth="200.0" GridPane.columnIndex="1" GridPane.rowIndex="1">
                     <GridPane.margin>
                        <Insets left="5.0" right="5.0" />
                     </GridPane.margin>
                  </ListView>
               </children>
            </GridPane>
         </children>
      </GridPane>
   </children>
</AnchorPane>