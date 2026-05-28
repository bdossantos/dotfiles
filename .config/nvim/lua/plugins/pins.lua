-- Pin all LazyVim-bundled plugins to the exact commits recorded in lazy-lock.json.
-- Only the commit field is set here; all other configuration comes from LazyVim defaults.
return {
  { "CopilotC-Nvim/CopilotChat.nvim", commit = "2db7b404110f92e6d9197fee9cb9a708ae205a10" }, -- latest: v4.7.4
  { "b0o/SchemaStore.nvim", commit = "e25e63f3b24fd6b8c2fc713107ad5d5594028eac" },
  { "fang2hou/blink-copilot", commit = "7ad8209b2f880a2840c94cdcd80ab4dc511d4f39" }, -- latest: v1.4.1
  { "Saghen/blink.cmp", commit = "0593548ee0b0978abf303d30f449234e07f951d1" }, -- latest: v1.10.2
  { "akinsho/bufferline.nvim", commit = "655133c3b4c3e5e05ec549b9f8cc2894ac6f51b3" }, -- v4.9.1
  { "catppuccin/nvim", name = "catppuccin", commit = "8edd468af4d63212b84d69b2ddb5ffc9023ef5eb" }, -- latest: v2.0.0
  { "p00f/clangd_extensions.nvim", commit = "78c2ecd659d54972be17aa6ba2deac3c53223b80" },
  { "Civitasv/cmake-tools.nvim", commit = "f9a3eb2be0b8148df470244e5c25aede3a3a28a5" },
  { "monaqa/dial.nvim", commit = "f2634758455cfa52a8acea6f142dcd6271a1bf57" }, -- latest: v0.5.1
  { "stevearc/dressing.nvim", commit = "2d7c2db2507fa3c4956142ee607431ddb2828639" }, -- latest: v3.1.1
  { "rafamadriz/friendly-snippets", commit = "6cd7280adead7f586db6fccbd15d2cac7e2188b9" },
  { "lewis6991/gitsigns.nvim", commit = "dd3f588bacbeb041be6facf1742e42097f62165d" }, -- latest: v2.1.0
  { "MagicDuck/grug-far.nvim", commit = "5506c2f59dc9ab2ed6c233585412b24d31d51521" },
  { "qvalentin/helm-ls.nvim", commit = "20df43509b02a3ce3c6b3eee254d6e2bffa9a370" },
  { "folke/lazydev.nvim", commit = "ff2cbcba459b637ec3fd165a2be59b7bbaeedf0d" }, -- latest: v1.10.0
  { "nvim-lualine/lualine.nvim", commit = "131a558e13f9f28b15cd235557150ccb23f89286" },
  { "iamcco/markdown-preview.nvim", commit = "a923f5fc5ba36a3b17e289dc35dc17f66d0548ee" }, -- latest: v0.0.10
  { "mason-org/mason-lspconfig.nvim", commit = "7b01e2974a47d489bb92f47a41e4c0088ea8f86e" }, -- latest: v2.2.0
  { "mason-org/mason.nvim", commit = "bb639d4bf385a4d89f478b83af4d770be05ab7eb" }, -- v2.3.0
  { "nvim-mini/mini.ai", commit = "4ce4c35e411ea329a15d4b15e9c89c2a3089e437" },
  { "nvim-mini/mini.icons", commit = "520995f1d75da0e4cc901ee95080b1ff2bc46b94" },
  { "nvim-mini/mini.pairs", commit = "30cf2f01c4aaa2033db67376b9924fa2442c05d6" },
  { "folke/noice.nvim", commit = "7bfd942445fb63089b59f97ca487d605e715f155" }, -- latest: v4.10.0
  { "MunifTanjim/nui.nvim", commit = "de740991c12411b663994b2860f1a4fd0937c130" }, -- latest: 0.4.0
  { "mfussenegger/nvim-ansible", commit = "c7f595d568b588942d4d0c37b5cd6cae3764a148" },
  { "mfussenegger/nvim-lint", commit = "d48f3a76189d03b2239f6df1b2f7e3fa8353743b" },
  { "neovim/nvim-lspconfig", commit = "6f76a3eeadc2ee235d74cd7d5319e95a261084af" }, -- latest: v2.9.0
  { "nvim-treesitter/nvim-treesitter", commit = "4916d6592ede8c07973490d9322f187e07dfefac" },
  { "nvim-treesitter/nvim-treesitter-textobjects", commit = "851e865342e5a4cb1ae23d31caf6e991e1c99f1e" },
  { "windwp/nvim-ts-autotag", commit = "88c1453db4ba7dd24131086fe51fdf74e587d275" },
  { "folke/persistence.nvim", commit = "b20b2a7887bd39c1a356980b45e03250f3dce49c" }, -- latest: v3.1.0
  { "nvim-lua/plenary.nvim", commit = "74b06c6c75e4eeb3108ec01852001636d85a932b" },
  { "MeanderingProgrammer/render-markdown.nvim", commit = "5adf0895310c1904e5abfaad40a2baad7fe44a07" }, -- latest: v8.12.0
  { "folke/snacks.nvim", commit = "882c996cf28183f4d63640de0b4c02ec886d01f2" }, -- latest: v2.31.0
  { "nvim-telescope/telescope-fzf-native.nvim", commit = "b25b749b9db64d375d782094e2b9dce53ad53a40" },
  { "ANGkeith/telescope-terraform-doc.nvim", commit = "66987fac94d12704fdfd90b857f4f648e31251c9" },
  { "cappyzawa/telescope-terraform.nvim", commit = "072c97023797ca1a874668aaa6ae0b74425335df" },
  { "nvim-telescope/telescope.nvim", commit = "7d324792b7943e4aa16ad007212e6acc6f9fe335" }, -- latest: v0.2.1
  { "folke/todo-comments.nvim", commit = "31e3c38ce9b29781e4422fc0322eb0a21f4e8668" }, -- v1.5.0
  { "folke/tokyonight.nvim", commit = "cdc07ac78467a233fd62c493de29a17e0cf2b2b6" }, -- latest: v4.14.1
  { "folke/trouble.nvim", commit = "bd67efe408d4816e25e8491cc5ad4088e708a69a" }, -- latest: v3.7.1
  { "folke/ts-comments.nvim", commit = "123a9fb12e7229342f807ec9e6de478b1102b041" }, -- latest: v1.5.0
  { "linux-cultist/venv-selector.nvim", commit = "cc4bb3975de8835291f9bb45889e96c6b2795fc4" },
  { "tpope/vim-dadbod", commit = "6d1d41da4873a445c5605f2005ad2c68c99d8770" },
  { "kristijanhusak/vim-dadbod-completion", commit = "a8dac0b3cf6132c80dc9b18bef36d4cf7a9e1fe6" },
  { "kristijanhusak/vim-dadbod-ui", commit = "07e92e22114cc5b1ba4938d99897d85b58e20475" },
  { "folke/which-key.nvim", commit = "3aab2147e74890957785941f0c1ad87d0a44c15a" }, -- latest: v3.17.0
  { "gbprod/yanky.nvim", commit = "b13d318dc7c816e2eee626dde61fa0a7237bc77e" }, -- latest: v2.0.0
}
