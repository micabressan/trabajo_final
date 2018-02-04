package com.company;

class Figure{
    private float x;
    private float y;

    public float getArea(){
        return 0;
    }
    public float getPerimeter(){
        return 0;
    }

    public void setX(float x) {
        this.x = x;
    }

    public void setY(float y) {
        this.y = y;
    }
    public Figure(float x, float y){
        setX(x);
        setY(y);
    }

    public float getX() {
        return x;
    }

    public float getY() {
        return y;
    }
}
class Rectangle extends Figure implements Moveable{
    private float height;
    private float width;

    public Rectangle(float x, float y, float height, float width) {
        super(x, y);
        setWidth(width);
        setHeight(height);
    }

    public float getHeight() {
        return height;
    }

    public float getWidth() {
        return width;
    }

    public void setHeight(float height) {
        this.height = height;
    }

    public void setWidth(float width) {
        this.width = width;
    }

    @Override
    public float getPerimeter() {
        return 4;
    }

    @Override
    public void move(float dx, float dy) {
        setX(getX()+dx);
        setY(getY()+dy);
    }

    @Override
    public void resize(float koeff) {
        setHeight(getHeight()*koeff);
        setWidth(getWidth()*koeff);
    }

    @Override
    public String toString() {
        return "Rectangle\nCenter: ("+(getX()+getWidth()/2)+", "+(getY()+getHeight()/2)+")\nHeight: "+getHeight()+"\nWidth: "+getWidth();
    }
}
class Circle extends Figure implements Moveable{
    private float radius;

    public float getRadius() {
        return radius;
    }

    public Circle(float x, float y, float radius) {
        super(x, y);
        setRadius(radius);
    }

    public void setRadius(float radius) {
        this.radius = radius;
    }

    @Override
    public float getArea() {
        return (float) Math.PI;
    }

    @Override
    public void move(float dx, float dy) {
        setX(getX()+dx);
        setY(getY()+dy);
    }

    @Override
    public void resize(float koeff) {
        setRadius(getRadius()*koeff);
    }

    @Override
    public String toString() {
        return "Circle\nCenter: ("+getX()+", "+getY()+")\nRadius: "+getRadius();
    }
}
interface  Moveable{
    void move(float dx, float dy);
    void resize(float koeff);
}
public class Main {

    public static void main(String[] args) {
        Circle circle = new Circle(10, 10, 1);
        Rectangle rectangle = new Rectangle(10, 10, 1, 1);
        System.out.println(circle.getArea());
        System.out.println(rectangle.getPerimeter());
        System.out.println();
        
        System.out.println(circle);
        circle.resize(3);
        System.out.println(circle);
        System.out.println();
        circle.move(4,5);
        System.out.println(circle);
        System.out.println();

        System.out.println(rectangle);
        System.out.println();
        rectangle.resize(4);
        System.out.println(rectangle);
        System.out.println();
        rectangle.move(3,2);
        System.out.println(rectangle);
    }
}