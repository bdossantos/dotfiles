-- Pin all LazyVim-bundled plugins to the exact commits recorded in lazy-lock.json.
-- Only the commit field is set here; all other configuration comes from LazyVim defaults.
return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    commit = "f5171b9575279995205fde6a6c06c2632bb0b9d9",
  }, -- latest: v4.7.4
  {
    "b0o/SchemaStore.nvim",
    commit = "5f2a3b5dc13f3622000cb488c9af505b933152e3",
  },
  {
    "fang2hou/blink-copilot",
    commit = "7ad8209b2f880a2840c94cdcd80ab4dc511d4f39",
  }, -- latest: v1.4.1
  {
    "Saghen/blink.cmp",
    branch = "v1",
    commit = "78336bc89ee5365633bcf754d93df01678b5c08f",
  }, -- latest: v1.10.2
  {
    "akinsho/bufferline.nvim",
    commit = "655133c3b4c3e5e05ec549b9f8cc2894ac6f51b3",
  }, -- v4.9.1
  {
    "catppuccin/nvim",
    name = "catppuccin",
    commit = "edefef779ab08ce1a4a404713e3012b0d202bd35",
  }, -- latest: v2.0.0
  {
    "p00f/clangd_extensions.nvim",
    commit = "78c2ecd659d54972be17aa6ba2deac3c53223b80",
  },
  {
    "Civitasv/cmake-tools.nvim",
    commit = "22859d754b5de738cfe9945e0910729f63deefd0",
  },
  { "monaqa/dial.nvim", commit = "f2634758455cfa52a8acea6f142dcd6271a1bf57" }, -- latest: v0.5.1
  {
    "stevearc/dressing.nvim",
    commit = "2d7c2db2507fa3c4956142ee607431ddb2828639",
  }, -- latest: v3.1.1
  {
    "rafamadriz/friendly-snippets",
    commit = "6cd7280adead7f586db6fccbd15d2cac7e2188b9",
  },
  {
    "lewis6991/gitsigns.nvim",
    commit = "5be654f2232c10ddcad19c1607a67b6b4b78fc29",
  }, -- latest: v2.1.0
  {
    "MagicDuck/grug-far.nvim",
    commit = "11595bf747edc270bce2069d1020502ad4ae56cf",
  },
  {
    "qvalentin/helm-ls.nvim",
    commit = "20df43509b02a3ce3c6b3eee254d6e2bffa9a370",
  },
  { "folke/lazydev.nvim", commit = "ff2cbcba459b637ec3fd165a2be59b7bbaeedf0d" }, -- latest: v1.10.0
  {
    "nvim-lualine/lualine.nvim",
    commit = "221ce6b2d999187044529f49da6554a92f740a96",
  },
  {
    "iamcco/markdown-preview.nvim",
    commit = "a923f5fc5ba36a3b17e289dc35dc17f66d0548ee",
  }, -- latest: v0.0.10
  {
    "mason-org/mason-lspconfig.nvim",
    commit = "24d4ab0838b250753b307a8747ade06dc99aed9d",
  }, -- latest: v2.3.0
  {
    "mason-org/mason.nvim",
    commit = "2a6940af80375532e5e9e7c1f2fc6319a1b7a69d",
  }, -- v2.3.1
  { "nvim-mini/mini.ai", commit = "25248c6aa002391936a6200f12d1466015987133" },
  {
    "nvim-mini/mini.icons",
    commit = "98faae31e9be1cc054ae63485e58ceb185efcad0",
  },
  {
    "nvim-mini/mini.pairs",
    commit = "b1c5a726921b7a8c9321e9a7a208aa0571de5810",
  },
  { "folke/noice.nvim", commit = "7bfd942445fb63089b59f97ca487d605e715f155" }, -- latest: v4.10.0
  {
    "MunifTanjim/nui.nvim",
    commit = "10fc361835c856ba4233ef5ea135b919bf3dce97",
  }, -- latest: 0.4.0
  {
    "mfussenegger/nvim-ansible",
    commit = "c7f595d568b588942d4d0c37b5cd6cae3764a148",
  },
  {
    "mfussenegger/nvim-lint",
    commit = "3d55c8f67c6ae5c15e1042571e107c7a3d5c5f4e",
  },
  {
    "neovim/nvim-lspconfig",
    commit = "af9adce488c75ca0a81017945c2b7fa7b461bc23",
  }, -- latest: v2.10.0
  {
    "nvim-treesitter/nvim-treesitter",
    commit = "8b98b4470eb326f1c7b50dae79f8c963568e5720",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    commit = "898ee307df58f854d11cd7edd06472574d48014e",
  },
  {
    "windwp/nvim-ts-autotag",
    commit = "88c1453db4ba7dd24131086fe51fdf74e587d275",
  },
  {
    "folke/persistence.nvim",
    commit = "b20b2a7887bd39c1a356980b45e03250f3dce49c",
  }, -- latest: v3.1.0
  {
    "nvim-lua/plenary.nvim",
    commit = "74b06c6c75e4eeb3108ec01852001636d85a932b",
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    commit = "4663eb3ecd538bd5062628fb6d95bbe6bdca78f6",
  }, -- latest: v8.13.0
  { "folke/snacks.nvim", commit = "882c996cf28183f4d63640de0b4c02ec886d01f2" }, -- latest: v2.31.0
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    commit = "b25b749b9db64d375d782094e2b9dce53ad53a40",
  },
  {
    "ANGkeith/telescope-terraform-doc.nvim",
    commit = "66987fac94d12704fdfd90b857f4f648e31251c9",
  },
  {
    "cappyzawa/telescope-terraform.nvim",
    commit = "072c97023797ca1a874668aaa6ae0b74425335df",
  },
  {
    "nvim-telescope/telescope.nvim",
    commit = "40aedd8a68c78a656a10a8d62d80c54af59420fb",
  }, -- latest: v0.2.1
  {
    "folke/todo-comments.nvim",
    commit = "31e3c38ce9b29781e4422fc0322eb0a21f4e8668",
  }, -- v1.5.0
  {
    "folke/tokyonight.nvim",
    commit = "cdc07ac78467a233fd62c493de29a17e0cf2b2b6",
  }, -- latest: v4.14.1
  { "folke/trouble.nvim", commit = "bd67efe408d4816e25e8491cc5ad4088e708a69a" }, -- latest: v3.7.1
  {
    "folke/ts-comments.nvim",
    commit = "a59d6092213447450191122c9346f309161504cb",
  }, -- latest: v1.5.0
  {
    "linux-cultist/venv-selector.nvim",
    commit = "cc4bb3975de8835291f9bb45889e96c6b2795fc4",
  },
  { "tpope/vim-dadbod", commit = "6d1d41da4873a445c5605f2005ad2c68c99d8770" },
  {
    "kristijanhusak/vim-dadbod-completion",
    commit = "a8dac0b3cf6132c80dc9b18bef36d4cf7a9e1fe6",
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    commit = "afd07819d8efcefc3317205b855ad4e3513b0011",
  },
  {
    "folke/which-key.nvim",
    commit = "3aab2147e74890957785941f0c1ad87d0a44c15a",
  }, -- latest: v3.17.0
  { "gbprod/yanky.nvim", commit = "dd6689fdda85f66cab7d9b1a1664625f3be0920d" }, -- latest: v2.0.0
}
