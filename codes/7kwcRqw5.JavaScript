/**
 *                       _
 *                      | |
 *    _____   _____ _ __| | __ _ _   _ _ __
 *   / _ \ \ / / _ \ '__| |/ _` | | | | '__|
 *  | (_) \ V /  __/ |  | | (_| | |_| | |
 *   \___/ \_/ \___|_|  |_|\__,_|\__, |_|
 *                                __/ |
 *                               |___/
 *
 * @file      Provides the saver
 * @author    Johannes Hertenstein <j6s@thej6s.com>, overlayr
 * @copyright 2015 overlayr, all rights reserved
 **/
/// <reference path="../../typings/tsd.d.ts" />

module overlayr.Lib {

    /**
     * Lib.Save: Simple Abstraction over the used storage method
     *
     * This abstraction was added to easily swap storage methods if we need.
     * Currently we are using localforage as storage method
     *
     * Lib.Save is a singleton, so you should always initialize it using the
     * Lib.Save.getInstace() function
     */
    export class Save {

        /**
         * A instance of Lib.Save
         */
        private static instance : Save = null;

        /**
         * Gets a singleton of Lib.Save
         */
        public static getInstance() : Save {
            if(Save.instance === null) {
                Save.instance = new Save();
            }

            return Save.instance;
        }

        /**
         * A localforage instance
         */
        private localforage : lf.ILocalForage<any> = null;

        /**
         * Constructor: stores the global localforage instance to this object
         */
        public constructor() {
            this.localforage = <lf.ILocalForage<any>>window['localforage'];
        }

        /**
         * Gets a given path in the storage method
         *
         * @param path
         * @returns {Promise<any>}
         */
        public get(path : string) : Promise<any> {
            log.debug('Lib.Save', path);
            dirty = true;
            return <Promise<any>> this.localforage.getItem(path);
        }

        /**
         * Sets a given path in the storage method
         *
         * @param path
         * @param content
         * @returns {Promise<any>}
         */
        public set(path : string, content : any) : Promise<any> {
            log.info('Lib.Save', path, content);
            return <Promise<any>>this.localforage.setItem(path, content);
        }

        /**
         * Checks if a given path is set in the storage method
         *
         * @param path
         * @returns {Promise}
         */
        public has(path : string) : Promise<boolean> {
            return new Promise((resolve : Function, reject : Function) => {
                this.localforage.keys((err: any, keys: Array<string>) => {
                    if(err) {
                        reject(err);
                        return;
                    }

                    resolve(keys.indexOf(path) !== -1);
                 });
            });
        }

        /**
         * Removes a given path from the storage method
         *
         * @param path
         */
        public remove(path : string) : Promise<any> {
            return new Promise((resolve : Function) => {
                this.localforage.removeItem(path).then(() => {
                    resolve();
                })
            });
        }
    }
}