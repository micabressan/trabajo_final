    for (uint8_t j=0; j<e->numPorts; j++)
    {
        ehci_resetPort(e,j);
        e->enabledPortFlag = true;

        e->ports[j] = malloc(sizeof(ehci_port_t), 0, "ehci_port_t");
        e->ports[j]->num = j+1;
        e->ports[j]->ehci = e;
        e->ports[j]->port.type = &USB_EHCI; // device manager
        e->ports[j]->port.data = e->ports[j];
        e->ports[j]->port.insertedDisk = 0;
        snprintf(e->ports[j]->port.name, 14, "EHCI-Port %u", j+1);
        attachPort(&e->ports[j]->port);

        if (e->USBtransferFlag && e->enabledPortFlag && e->OpRegs->PORTSC[j] == (PSTS_POWERON | PSTS_ENABLED | PSTS_CONNECTED)) // high speed, enabled, device attached
        {
            textColor(IMPORTANT);
            printf("Port %u: high speed enabled, device attached\n",j+1);
            textColor(TEXT);

            setupUSBDevice(e, j); // TEST
        }
    }