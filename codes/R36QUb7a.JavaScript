import {Figure} from "./Figure";

export class Player {

    constructor(figureMatrix, position) {
        this.figureMatrix = figureMatrix;
        this.position = position;
    }

    reset(gameMatrix, scene) {
        const figureTypes = ['I', 'L', 'J', 'O', 'T', 'S', 'Z'];
        this.figureMatrix = new Figure(figureTypes[figureTypes.length * Math.random() | 0]).create();
        this.position.y = 0;
        this.position.x = (gameMatrix[0].length / 2 | 0) - (this.figureMatrix[0].length / 2 | 0);
        if (scene.collide()) {
            gameMatrix.forEach(row => row.fill(0));
        }
    }

    move(scene, direction) {
        this.position.x += direction;
        if (scene.collide()) {
            this.position.x -= direction;
        }
    }

    rotate(figureMatrix, direction) {
        for (let y = 0; y < figureMatrix.length; y++) {
            for (let x = 0; x < y; x++) {
                [
                    figureMatrix[x][y],
                    figureMatrix[y][x]
                ] = [
                    figureMatrix[y][x],
                    figureMatrix[x][y]
                ];

                if (direction > 0) {
                    figureMatrix.forEach(row => row.reverse());
                } else {
                    figureMatrix.reverse();
                }
            }
        }
    }

    playerRotate(dir) {
        const pos = player.position.x;
        let offset = 1;

        rotate(player.figureMatrix, dir);
        while (scene.collide()) {
            player.position.x += offset;
            offset = -(offset + (offset > 0 ? 1 : -1));
            if (offset > player.figureMatrix[0].length) {
                rotate(player.figureMatrix, -dir);
                player.position.x = pos;
                return;
            }
        }
    }
}