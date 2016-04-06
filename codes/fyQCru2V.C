int func_accessctrl_ssh_set_port(char **arg){

        long ret;
        int i, stringLength = strlen(final_cmd);

        for(i = 0; i < stringLength; i++)
        {
                if(isdigit(final_cmd[i]) == 0)
                        break;
        }

        if(i == stringLength){
                ret = strtol(final_cmd, (char **)NULL, 10);
                printf("The number is %ld\n", ret);
        }
        else
                printf("please enter a valid port number\n");

        return (0);
}