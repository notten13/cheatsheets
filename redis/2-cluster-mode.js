const ioredis = require("ioredis");

const cluster = new ioredis.Cluster([
    {
        host: "127.0.0.1",
        port: 7000,
    },
    {
        host: "127.0.0.1",
        port: 7001,
    },
    {
        host: "127.0.0.1",
        port: 7002,
    },
], {
    clusterRetryStrategy: function (times) {
        // This is invoked when we completely lose access to the cluster
        // i.e. we lose our connection to the last available node
        console.log('Executing cluster retry strategy', times);
        
        if (times === 3) return null;
        
        return 3000;
    }
});

(async () => {
    try {
        cluster.on('connect', (event) => {
            console.log('');
            console.log('connect');
            console.log('');
        });

        cluster.on('close', (event) => {
            console.log('');
            console.log('close');
            console.log('');
        });

        cluster.on('reconnecting', (event) => {
            console.log('');
            console.log('reconnecting');
            console.log('');
        });

        cluster.on('end', (event) => {
            console.log('');
            console.log('end');
            console.log('');
        });

        cluster.on('+node', (event) => {
            console.log('');
            console.log('+node');
            console.log('');
        });

        cluster.on('-node', (event) => {
            console.log('');
            console.log('-node');
            console.log('');
        });

        cluster.on('node error', (event) => {
            console.log('');
            console.log('node error');
            console.log('');
        });	

        // Wait for the nodes to be created
        await new Promise((resolve) => setTimeout(resolve, 3000));

        cluster.nodes().forEach((node) => {
            node.on("connect", (event) => {
                console.log("");
                console.log("Node event: connect");
                console.log("");
            });
    
            node.on("error", (event) => {
                console.log("");
                console.log("Node event: error");
                console.log("");
            });
    
            node.on("close", (event) => {
                console.log("");
                console.log("Node event: close");
                console.log("");
            });
    
            node.on("reconnecting", (event) => {
                console.log("");
                console.log("Node event: reconnecting");
                console.log(`Reconnection attemps: ${reconnectionAttempts++}`);
                console.log("");
            });
    
            node.on("end", (event) => {
                console.log("");
                console.log("Node event: end");
                console.log("");
            });
        });

        await cluster.set("test", "1234");

        console.log('Pausing for 10 seconds, break something now!');

        await new Promise((resolve) => setTimeout(resolve, 10000));
        
        console.log('Resuming, fetching key...');

        const value = await cluster.get("test");
        console.log("Value: ", value);
    } catch (err) {
        console.error("An error has occurred:", err);
    } finally {
        // cluster.disconnect();
    }
})();
