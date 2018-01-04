    /**
     * Ejecuta un comando de la API.
     * @param string $comando Comando a ejecutar.
     */
    public function ejecutar($comando)
    {

        $payload = json_encode($this->parámetros);

        $url = $this->url . '/' . $comando;

        $c = curl_init($url);
        curl_setopt($c, CURLOPT_HTTPHEADER, [
            'X-Token: ' . $this->token,
            'X-Formato: json'
        ]);
        curl_setopt($c, CURLOPT_POST, true);
        curl_setopt($c, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($c, CURLOPT_POSTFIELDS, $payload);

        if ($this->disableSSLAuth) {
            curl_setopt($c, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($c, CURLOPT_SSL_VERIFYHOST, false);
        }

        $result = curl_exec($c);

        if ($result === false) {
            throw new RuntimeException(curl_error($c));
        } else {
            $status = json_decode($result, true);
            // Esto _nunca_ debe pasar...
            if (is_null($status)) {
                echo "ERROR! OMAYGA!";
                var_dump($url);
                var_dump($comando);
                var_dump($payload);
                echo($result);
                exit;
            }

            if ($status['estado'] != 'ok') {
                throw new RuntimeException($status['descripcion_error']);
            }

        }

        curl_close($c);

        return $status;
    }