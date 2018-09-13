module.exports = {
    'outputDir': '../backend/root',
    devServer: {
        proxy: {
            '/api': {
                target: 'http://localhost:8080',
                changeOrigin: true
            }
        }
    }
}
