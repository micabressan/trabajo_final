package com.company;

import java.util.ArrayList;

public class Map {

    private ArrayList<Element> elementList = new ArrayList<Element>();
    private ArrayList<Bullet> bulletList = new ArrayList<Bullet>();
    //The starting point of the map
    private char[][] coordinates = {{' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}};

    //Constructor for the map, player is added automatically as the first element (get(0))
    public Map() {
        addElement(new Player());
    }

    public void printMap() {
        int mapHeight = 29;
        int mapWidth = 25;
        boolean print = false;

        //Goes through the whole map
        for (int i = 0; i < mapHeight; i++) {
            for (int l = 0; l < mapWidth; l++) {
                ArrayList<int[]> elementCoordinatesList;
                int[] elementCoordinates;
                print = false;

                //checks every elements coordinates if it should be printed at the spot of the first two cycles
                for (int k = 0; k < elementList.size(); k++) {
                    elementCoordinatesList = elementList.get(k).getCoordinates();
                    for (int h = 0; h < elementCoordinatesList.size(); h++) {
                        elementCoordinates = elementCoordinatesList.get(h);
                        if (elementCoordinates[0] == i && elementCoordinates[1] == l) {
                            print = true;
                        }
                    }
                }
                //checks every bullets coordinates if it should be printed at the spot of the first two cycles
                for (int k = 0; k < bulletList.size(); k++) {
                    elementCoordinatesList = bulletList.get(k).getCoordinates();
                    for (int h = 0; h < elementCoordinatesList.size(); h++) {
                        elementCoordinates = elementCoordinatesList.get(h);
                        if (elementCoordinates[0] == i && elementCoordinates[1] == l) {
                            print = true;
                        }
                    }
                }
                if (print == true) {
                    System.out.print("* ");
                } else {
                    System.out.print(coordinates[i][l] + " ");
                }
            }
            System.out.println("");
        }
    }

    public void movePlayer(int x) {
        if (x == 1) changeElementCoordinates(0, 0, -1);
        if (x == 2) changeElementCoordinates(0, 0, 1);
    }

    public void addElement(Element tempElement) {
        elementList.add(tempElement);
    }

    public void changeElementCoordinates(int no, int x, int y) {
        elementList.get(no).setNewCoordinates(x, y);
    }

    public void setAllObjectsToGoDown() {
        for (int i = 1; i < elementList.size(); i++) {
            elementList.get(i).pushDown();
        }
    }

    public void addBulletUp() {
        ArrayList<int[]> elementCoordinatesList = elementList.get(0).getCoordinates();
        int[] elementCoordinates;

        //4 stands for the middle of the player coordinate
        elementCoordinates = elementCoordinatesList.get(4);

        //2 stands for a bullet pushed 2 steps up from the player object
        bulletList.add(new Bullet(elementCoordinates[0] - 2, elementCoordinates[1], true));
    }

    public void bulletMovement() {
        for (int i = 0; i < bulletList.size(); i++) {
            bulletList.get(i).pushUpOrDown();
        }
    }

    public void checkBulletHits() {
        ArrayList<int[]> bulletCoordinatesList;
        ArrayList<int[]> elementCoordinateList;
        int[] bulletCoordinates;
        int[] elementCoordinates;
        boolean bulletRemoved = false;

        for (int i = 0; i < bulletList.size(); i++) {
            bulletRemoved = false;
            bulletCoordinatesList = bulletList.get(i).getCoordinates();
            bulletCoordinates = bulletCoordinatesList.get(0);

            for (int k = 0; k < elementList.size(); k++) {
                elementCoordinateList = elementList.get(k).getCoordinates();
                for (int h = 0; h < elementCoordinateList.size(); h++) {
                    elementCoordinates = elementCoordinateList.get(h);

                    //We don't need a cycle for the bullet coordinates, because the bullet list only has one element
                    if (elementCoordinates[0] == bulletCoordinates[0] && elementCoordinates[1] == bulletCoordinates[1]) {
                        elementList.get(k).setLivesMinus1();

                        if (elementList.get(k).getLives() == 0) elementList.remove(k);
                        bulletList.remove(i);
                        bulletRemoved = true;
                    }
                }
            }

            //0 and 30 are the map edges
            if ((bulletRemoved == false) && (bulletCoordinates[0] < 0 || bulletCoordinates[0] > 30)) bulletList.remove(i);
        }
    }

    public int getRandomShooter() {
        ArrayList<Integer> bottomShooterArray = new ArrayList<Integer>();
        int bottomArray = -1;
        ArrayList<int[]> elementCoordinatesList;
        int[] elementCoordinates;

        for (int i = 1; i < elementList.size(); i++) {
            if (elementList.get(i).isShooter() == true) {
                elementCoordinatesList = elementList.get(i).getCoordinates();
                //5 is the standard for the elements middle coordinate
                elementCoordinates = elementCoordinatesList.get(5);

                if (elementCoordinates[0] >= bottomArray) {
                    if (elementCoordinates[0] > bottomArray) bottomShooterArray.clear();
                    bottomShooterArray.add(i);
                    bottomArray = elementCoordinates[0];
                }
            }
        }
        //Returns random number
        return bottomShooterArray.get((int) (Math.random() * bottomShooterArray.size() + 0));
    }

    public void addEnemyShot() {
        ArrayList<int[]> elementCoordinatesList = elementList.get(getRandomShooter()).getCoordinates();
        int[] elementCoordinates = elementCoordinatesList.get(5);
        bulletList.add(new Bullet(elementCoordinates[0] + 2, elementCoordinates[1], false));
    }

    public int getElementListSize() {
        return elementList.size();
    }

}