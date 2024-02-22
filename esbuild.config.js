import gsap from "gsap"
import swiper from "swiper"

const path = require('path');

require("esbuild").build({
    entryPoints: ["application.js"],
    bundle: true,
    outdir: path.join(process.cwd(), "app/assets/builds"),
    absWorkingDir: path.join(process.cwd(), "app/javascript"),
    watch: true,
    // custom plugins will be inserted is this array
    plugins: [
        gsap({
            extensions: ['.ts', '.js'],
            onResolved: (resolved) => {
                if (resolved.includes('node_modules')) {
                    return {
                        external: true,
                    }
                }
                return resolved
            },
        })
    ],
}).catch(() => process.exit(1));