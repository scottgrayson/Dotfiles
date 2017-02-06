module.exports = {
  config: {
    // default font size in pixels for all tabs
    fontSize: 18,

    // font family with optional fallbacks
    fontFamily: '"Fira Code", Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',

    // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
    cursorColor: 'rgba(248,28,229,0.8)',

    // `BEAM` for |, `UNDERLINE` for _, `BLOCK` for █
    cursorShape: 'BLOCK',

    // custom css to embed in the main window
    css: `
      x-screen x-row { font-variant-ligatures: contextual; background-color: #002b36 }
    `,

    // custom css to embed in the terminal window
    termCSS: '',

    // custom padding (css format, i.e.: `top right bottom left`)
    padding: '0px 0 15px 0px',

    // set to false for no bell
    bell: 'SOUND',

    // if true, selected text will automatically be copied to the clipboard
    copyOnSelect: false

    // for advanced config flags please refer to https://hyper.is/#cfg
  },

  plugins: [
    // Themes
    // 'hyperpunk',
    // 'hyperterm-monokai',
    // 'hyperterm-atom-dark',
    // 'hyperterm-gruvbox-dark',
    // 'hyperblue',
    // 'hyper-nord',
    //'hyper-solarized-dark',

    // Plugins
    'hyperlinks',
    'hyperline',
    'hyperterm-dibdabs'
  ],

  localPlugins: [
    'hyper-solarized-dark'
  ],

  hyperline: {
    background: 'transparent',
    color: 'black',
    plugins: [
      {
        name: 'memory',
        options: {
          color: 'white'
        }
      },
      {
        name: 'cpu',
        options: {
          colors: {
            high: 'lightRed',
            moderate: 'lightYellow',
            low: 'lightGreen'
          }
        }
      },
      {
        name: 'network',
        options: {
          color: 'lightCyan'
        }
      }
    ]
  }
}
