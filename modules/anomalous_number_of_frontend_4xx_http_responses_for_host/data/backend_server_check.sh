
   for ${BACKEND_SERVER} in ${LIST_OF_BACKEND_SERVERS}; do

       nc -zv ${BACKEND_SERVER} ${BACKEND_SERVER_PORT}

   done

   traceroute ${BACKEND_SERVER}