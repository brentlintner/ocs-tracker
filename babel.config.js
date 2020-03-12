module.exports = {
  "presets": [
    [
      "@babel/env",
      {
        "modules": false,
        "forceAllTransforms": true,
        "targets": {
          "browsers": "> 1%"
        }
      }
    ],
    "@babel/preset-react"
  ],
  "plugins": [
    "@babel/plugin-proposal-object-rest-spread",
    "@babel/plugin-syntax-dynamic-import",
    [
      "@babel/plugin-proposal-class-properties",
      {
        "spec": true
      }
    ]
  ]
}
