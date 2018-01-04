import { Injectable } from '@angular/core';
import { HttpModule } from '@angular/http';
import { Http, Headers } from '@angular/http';

import { NgZone } from '@angular/core';
import { BackgroundGeolocation } from '@ionic-native/background-geolocation';
import { Geolocation, Geoposition } from '@ionic-native/geolocation';

import 'rxjs/add/operator/map';
import 'rxjs/add/operator/filter';
import 'rxjs/add/operator/toPromise';

@Injectable()
export class LocationTrackerProvider {
 
  public watch: any;   
  public lat: number = 0;
  public lng: number = 0;

  cdFuncionario: string;
  
  headers = new Headers({});

  constructor(public http: HttpModule,
    private httpWs:Http, 
    public zone: NgZone,
    public geolocation:Geolocation,
    public backgroundGeolocation:BackgroundGeolocation) {
  }

  private catchError(error: any): Promise<any> {
    return Promise.reject(error.message || "Erro de Conexao");
  }

  startTracking() {
   
    // Background Tracking
    let config = {
      desiredAccuracy: 0,
      stationaryRadius: 20,
      distanceFilter: 10,
      debug: true,
      frequency: 3000,
      interval: 3000
    };
   
    this.backgroundGeolocation.configure(config).subscribe((location) => {

      console.log('BackgroundGeolocation:  ' + location.latitude + ',' + location.longitude);
   
      // Run update inside of Angular's zone
      this.zone.run(() => {

        this.lat = location.latitude;
        this.lng = location.longitude;

        // Enviar WebService
        let dados = new FormData();

        dados.append('matricula', localStorage.getItem('matricula'));
        dados.append('latitude', this.lat.toString());
        dados.append('longitude', this.lng.toString());
        dados.append('imei', localStorage.getItem('imei'));
        dados.append('token', localStorage.getItem('token'));

        this.httpWs.post('http://192.168.0.111/wsfiscalizacaopmcf/wsSalvarLocalizacao.ashx', dados, { headers: this.headers }).toPromise().then(res=>res.json()).catch(this.catchError);

      });
    
  
    }, (err) => {
   
      console.log(err);
   
    });

    // Turn ON the background-geolocation system.
    this.backgroundGeolocation.start();
   
    // Foreground Tracking
    let options = {
      frequency: 3000,
      interval: 3000,
      enableHighAccuracy: true
    };
   
    this.watch = this.geolocation.watchPosition(options).filter((p: any) => p.code === undefined).subscribe((position: Geoposition) => {
   
      // Run update inside of Angular's zone
      this.zone.run(() => {

        this.lat = position.coords.latitude;
        this.lng = position.coords.longitude;

        // Enviar WebService
        let dados = new FormData();

        dados.append('matricula', localStorage.getItem('matricula'));
        dados.append('latitude', this.lat.toString());
        dados.append('longitude', this.lng.toString());
        dados.append('imei', localStorage.getItem('imei'));
        dados.append('token', localStorage.getItem('token'));

        this.httpWs.post('http://192.168.0.111/wsfiscalizacaopmcf/wsSalvarLocalizacao.ashx', dados, { headers: this.headers }).toPromise().then(res=>res.json()).catch(this.catchError);

      });
   
   });
   
  }
 
  // Pausar a Localização
  stopTracking() {

    this.backgroundGeolocation.finish();
    this.watch.unsubscribe();
   
  }
 
}