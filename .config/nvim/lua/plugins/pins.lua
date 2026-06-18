-- Pin all LazyVim-bundled plugins to the exact commits recorded in lazy-lock.json.
-- Only the commit field is set here; all other configuration comes from LazyVim defaults.
return {
  { "CopilotC-Nvim/CopilotChat.nvim", commit = "f0c2a23ab79dc295f5e0eef0d8b587a39020c852" }, -- latest: v4.7.4
  { "b0o/SchemaStore.nvim", commit = "735540a7602bffd1b07deab7d508affb57b78c64" },
  { "fang2hou/blink-copilot", commit = "7ad8209b2f880a2840c94cdcd80ab4dc511d4f39" }, -- latest: v1.4.1
  { "Saghen/blink.cmp", commit = "26ec6f0a1a8101eb134f8b8568d6099be015fe70" }, -- latest: v1.10.2
  { "akinsho/bufferline.nvim", commit = "655133c3b4c3e5e05ec549b9f8cc2894ac6f51b3" }, -- v4.9.1
  { "catppuccin/nvim", name = "catppuccin", commit = "49a926655a2f5579e9c276470fc300baaa49e524" }, -- latest: v2.0.0
  { "p00f/clangd_extensions.nvim", commit = "78c2ecd659d54972be17aa6ba2deac3c53223b80" },
  { "Civitasv/cmake-tools.nvim", commit = "98cdc162572a7b77733030425d8d045d68f2a1fd" },
  { "monaqa/dial.nvim", commit = "f2634758455cfa52a8acea6f142dcd6271a1bf57" }, -- latest: v0.5.1
  { "stevearc/dressing.nvim", commit = "2d7c2db2507fa3c4956142ee607431ddb2828639" }, -- latest: v3.1.1
  { "rafamadriz/friendly-snippets", commit = "6cd7280adead7f586db6fccbd15d2cac7e2188b9" },
  { "lewis6991/gitsigns.nvim", commit = "25050e4ed39e628282831d4cbecb1850454ce915" }, -- latest: v2.1.0
  { "MagicDuck/grug-far.nvim", commit = "c995bbacf8229dc096ec1c3d60f8531059c86c1b" },
  { "qvalentin/helm-ls.nvim", commit = "20df43509b02a3ce3c6b3eee254d6e2bffa9a370" },
  { "folke/lazydev.nvim", commit = "ff2cbcba459b637ec3fd165a2be59b7bbaeedf0d" }, -- latest: v1.10.0
  { "nvim-lualine/lualine.nvim", commit = "221ce6b2d999187044529f49da6554a92f740a96" },
  { "iamcco/markdown-preview.nvim", commit = "a923f5fc5ba36a3b17e289dc35dc17f66d0548ee" }, -- latest: v0.0.10
  { "mason-org/mason-lspconfig.nvim", commit = "21c5b3ebeaa0412e28096bb0701434c51c1fbf76" }, -- latest: v2.3.0
  { "mason-org/mason.nvim", commit = "2a6940af80375532e5e9e7c1f2fc6319a1b7a69d" }, -- v2.3.1
  { "nvim-mini/mini.ai", commit = "4511b3481707c1d021485475d34f2ed2a50bf47b" },
  { "nvim-mini/mini.icons", commit = "ac38c983aed0a2bd32a65ca3e2348e12e58ca292" },
  { "nvim-mini/mini.pairs", commit = "30cf2f01c4aaa2033db67376b9924fa2442c05d6" },
  { "folke/noice.nvim", commit = "7bfd942445fb63089b59f97ca487d605e715f155" }, -- latest: v4.10.0
  { "MunifTanjim/nui.nvim", commit = "de740991c12411b663994b2860f1a4fd0937c130" }, -- latest: 0.4.0
  { "mfussenegger/nvim-ansible", commit = "c7f595d568b588942d4d0c37b5cd6cae3764a148" },
  { "mfussenegger/nvim-lint", commit = "4b7957daf4b81eb578114bd6fcf20b6f5a2b59e8" },
  { "neovim/nvim-lspconfig", commit = "a683e0ddf0cf64c6cd689e18ffb480ade3c162b7" }, -- latest: v2.10.0
  { "nvim-treesitter/nvim-treesitter", commit = "4916d6592ede8c07973490d9322f187e07dfefac" },
  { "nvim-treesitter/nvim-treesitter-textobjects", commit = "851e865342e5a4cb1ae23d31caf6e991e1c99f1e" },
  { "windwp/nvim-ts-autotag", commit = "88c1453db4ba7dd24131086fe51fdf74e587d275" },
  { "folke/persistence.nvim", commit = "b20b2a7887bd39c1a356980b45e03250f3dce49c" }, -- latest: v3.1.0
  { "nvim-lua/plenary.nvim", commit = "74b06c6c75e4eeb3108ec01852001636d85a932b" },
  { "MeanderingProgrammer/render-markdown.nvim", commit = "f422cb5c6855f150e2ddcfaf44e7157b98b34f6a" }, -- latest: v8.13.0
  { "folke/snacks.nvim", commit = "882c996cf28183f4d63640de0b4c02ec886d01f2" }, -- latest: v2.31.0
  { "nvim-telescope/telescope-fzf-native.nvim", commit = "b25b749b9db64d375d782094e2b9dce53ad53a40" },
  { "ANGkeith/telescope-terraform-doc.nvim", commit = "66987fac94d12704fdfd90b857f4f648e31251c9" },
  { "cappyzawa/telescope-terraform.nvim", commit = "072c97023797ca1a874668aaa6ae0b74425335df" },
  { "nvim-telescope/telescope.nvim", commit = "9377230aa5305d9e9aca4ed8dadf1070fb4aa9fc" }, -- latest: v0.2.1
  { "folke/todo-comments.nvim", commit = "31e3c38ce9b29781e4422fc0322eb0a21f4e8668" }, -- v1.5.0
  { "folke/tokyonight.nvim", commit = "cdc07ac78467a233fd62c493de29a17e0cf2b2b6" }, -- latest: v4.14.1
  { "folke/trouble.nvim", commit = "bd67efe408d4816e25e8491cc5ad4088e708a69a" }, -- latest: v3.7.1
  { "folke/ts-comments.nvim", commit = "123a9fb12e7229342f807ec9e6de478b1102b041" }, -- latest: v1.5.0
  { "linux-cultist/venv-selector.nvim", commit = "cc4bb3975de8835291f9bb45889e96c6b2795fc4" },
  { "tpope/vim-dadbod", commit = "6d1d41da4873a445c5605f2005ad2c68c99d8770" },
  { "kristijanhusak/vim-dadbod-completion", commit = "a8dac0b3cf6132c80dc9b18bef36d4cf7a9e1fe6" },
  { "kristijanhusak/vim-dadbod-ui", commit = "07e92e22114cc5b1ba4938d99897d85b58e20475" },
  { "folke/which-key.nvim", commit = "3aab2147e74890957785941f0c1ad87d0a44c15a" }, -- latest: v3.17.0
  { "gbprod/yanky.nvim", commit = "020c22d0cfa60358569e49d1d7b91630f175aef0" }, -- latest: v2.0.0
}
