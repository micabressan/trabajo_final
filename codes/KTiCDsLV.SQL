USE [DEMO]
GO
/****** Object:  Table [dbo].[ACY010]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACY010](
	[ACY_FILIAL] [varchar](2) NOT NULL,
	[ACY_GRPVEN] [varchar](6) NOT NULL,
	[ACY_DESCRI] [varchar](30) NOT NULL,
	[ACY_GRPSUP] [varchar](6) NOT NULL,
	[ACY_CHAVE] [varchar](20) NOT NULL,
	[D_E_L_E_T_] [varchar](1) NOT NULL,
	[R_E_C_N_O_] [int] NOT NULL,
	[R_E_C_D_E_L_] [int] NOT NULL,
	[ACY_X_JRCP] [varchar](1) NOT NULL,
	[ACY_X_COMZ] [varchar](1) NOT NULL,
	[ACY_X_CBAN] [varchar](1) NOT NULL,
	[ACY_X_AGCN] [varchar](1) NOT NULL,
	[ACY_X_TARB] [varchar](1) NOT NULL,
	[ACY_X_COMI] [varchar](1) NOT NULL,
	[ACY_X_PROT] [varchar](1) NOT NULL,
	[ACY_X_DIAB] [float] NOT NULL,
	[ACY_X_TAB] [varchar](3) NOT NULL,
	[ACY_X_COM] [float] NOT NULL,
	[ACY_X_MARG] [float] NOT NULL,
	[ACY_X_FRET] [float] NOT NULL,
 CONSTRAINT [ACY010_PK] PRIMARY KEY CLUSTERED 
(
	[R_E_C_N_O_] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BMAC_AGENDA]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BMAC_AGENDA](
	[CLIENTE] [char](6) NULL,
	[DATA] [datetime] NULL,
	[LEMBRETE] [varchar](100) NULL,
	[ATIVO] [char](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BMAC_ATENDIMENTO]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BMAC_ATENDIMENTO](
	[ATENDIMENTO] [int] NOT NULL,
	[USUARIO] [int] NULL,
	[VENDEDOR] [char](6) NULL,
	[DATA] [datetime] NULL,
	[HORAINI] [char](8) NULL,
	[HORAFIM] [char](8) NULL,
	[OPERACAO] [varchar](20) NULL,
	[PEDIDO] [int] NULL,
	[CLIENTE] [char](6) NULL,
	[NOME] [varchar](50) NULL,
	[CONCLUSAO] [varchar](30) NULL,
	[OBS] [varchar](50) NULL,
	[IP] [varchar](15) NULL,
 CONSTRAINT [PK_BMAC_ATENDIMENTO] PRIMARY KEY CLUSTERED 
(
	[ATENDIMENTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BMAC_BASICO]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BMAC_BASICO](
	[ITEM] [int] NOT NULL,
	[GRUPOPRO] [char](6) NOT NULL,
	[DESCRICAO] [varchar](50) NOT NULL,
 CONSTRAINT [PK_BMAC_BASICO_1] PRIMARY KEY CLUSTERED 
(
	[ITEM] ASC,
	[GRUPOPRO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BMAC_BLOQUEIO]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BMAC_BLOQUEIO](
	[USUARIO] [int] NULL,
	[DATA] [datetime] NULL,
	[HORA] [char](8) NULL,
	[PEDIDO] [int] NULL,
	[TOTAL] [numeric](9, 2) NULL,
	[PAGTO_COD] [int] NULL,
	[BLOQUEIO] [varchar](30) NULL,
	[DESCRICAO] [varchar](100) NULL,
	[LIB_DATA] [datetime] NULL,
	[LIB_HORA] [char](8) NULL,
	[LIB_USUARIO] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BMAC_CLIENTES2]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BMAC_CLIENTES2](
	[CLIENTE] [int] NULL,
	[NOME] [varchar](40) NULL,
	[ENDERECO] [varchar](40) NULL,
	[COMPLEMENTO] [varchar](50) NULL,
	[BAIRRO] [varchar](30) NULL,
	[CIDADE] [varchar](25) NULL,
	[ESTADO] [char](2) NULL,
	[CODMUN] [varchar](5) NULL,
	[CEP] [varchar](8) NULL,
	[FONES] [varchar](50) NULL,
	[EMAIL] [varchar](60) NULL,
	[TIPO] [varchar](8) NULL,
	[RG] [varchar](18) NULL,
	[CPF] [varchar](18) NULL,
	[ESPECIALIDADE] [varchar](50) NULL,
	[CROTPD] [varchar](30) NULL,
	[GRUPO] [varchar](7) NULL,
	[VENDEDOR] [char](6) NULL,
	[STATUS] [char](1) NULL,
	[NOVO] [char](6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BMAC_ENCOMENDAS]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BMAC_ENCOMENDAS](
	[ENCOMENDA] [int] NOT NULL,
	[DATA] [datetime] NULL,
	[VENDEDOR] [char](6) NULL,
	[CLIENTE] [char](6) NULL,
	[NOME] [varchar](50) NULL,
	[PRODUTO] [varchar](15) NULL,
	[DESCRICAO] [varchar](50) NULL,
	[QTDE] [int] NULL,
	[OBS] [varchar](50) NULL,
	[STATUS] [char](1) NULL,
	[RETORNO] [varchar](50) NULL,
	[ORCAMENTO] [int] NULL,
 CONSTRAINT [PK_BMAC_ENCOMENDA] PRIMARY KEY CLUSTERED 
(
	[ENCOMENDA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BMAC_FRETE]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BMAC_FRETE](
	[TRANSP] [char](6) NOT NULL,
	[CIDADE] [varchar](50) NULL,
	[ESTADO] [char](2) NULL,
	[CEP_INI] [char](8) NULL,
	[CEP_FIM] [char](8) NULL,
	[PRAZO_MIN] [int] NULL,
	[PRAZO_MAX] [int] NULL,
	[OBS] [varchar](50) NULL,
	[PESO_INI] [numeric](9, 3) NULL,
	[PESO_FIM] [numeric](9, 3) NULL,
	[PRECO] [numeric](9, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BMAC_LOG]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BMAC_LOG](
	[USUARIO] [int] NULL,
	[DATA] [datetime] NULL,
	[TELA] [varchar](30) NULL,
	[OPERACAO] [varchar](30) NULL,
	[CODIGO] [varchar](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BMAC_MEDIA1]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BMAC_MEDIA1](
	[VENDEDOR] [char](6) NOT NULL,
	[PRODUTO] [char](15) NOT NULL,
	[GRUPO] [nchar](10) NOT NULL,
	[MEDIA] [numeric](9, 2) NOT NULL,
 CONSTRAINT [PK_BMAC_MEDIA1] PRIMARY KEY CLUSTERED 
(
	[VENDEDOR] ASC,
	[PRODUTO] ASC,
	[GRUPO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BMAC_MEDIA2]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BMAC_MEDIA2](
	[PRODUTO] [char](15) NOT NULL,
	[ATACADO] [numeric](9, 2) NULL,
	[VAREJO] [numeric](9, 2) NULL,
 CONSTRAINT [PK_BMAC_MEDIA2] PRIMARY KEY CLUSTERED 
(
	[PRODUTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BMAC_METAS]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BMAC_METAS](
	[FILIAL] [char](2) NULL,
	[VENDEDOR] [char](6) NULL,
	[ANO] [char](4) NULL,
	[MES] [char](2) NULL,
	[META] [decimal](11, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BMAC_PAGTO]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BMAC_PAGTO](
	[FORMA_PAGTO] [int] NOT NULL,
	[ORDEM] [char](4) NULL,
	[GRUPO] [char](6) NOT NULL,
	[DESCRICAO] [varchar](35) NOT NULL,
	[FORMA] [char](3) NOT NULL,
	[COND] [char](3) NOT NULL,
	[PARCELAS] [int] NULL,
	[PARTIRDE] [numeric](9, 2) NULL,
	[FATOR] [numeric](5, 2) NULL,
	[COMISSAO] [numeric](5, 2) NULL,
	[DIAS] [varchar](100) NULL,
	[MORELLI] [int] NULL,
	[AVISTA] [char](1) NULL,
	[PRAZO_MAXIMO] [int] NULL,
	[FATOR_REAL] [numeric](5, 2) NULL,
 CONSTRAINT [PK_BMAC_PAGTO] PRIMARY KEY CLUSTERED 
(
	[FORMA_PAGTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BMAC_PARAMETROS]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BMAC_PARAMETROS](
	[DOMINIO] [varchar](10) NULL,
	[PARAMETRO] [varchar](30) NULL,
	[TIPO] [varchar](10) NULL,
	[VALOR] [varchar](500) NULL,
	[ORDEM] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BMAC_PEDIDOS]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BMAC_PEDIDOS](
	[TIPO] [varchar](9) NULL,
	[STATUS] [varchar](20) NULL,
	[PEDIDO] [int] NOT NULL,
	[USUARIO] [int] NULL,
	[NOME_USUARIO] [varchar](20) NULL,
	[CADASTRO] [datetime] NULL,
	[DATA] [datetime] NULL,
	[HORA] [char](8) NULL,
	[CLIENTE] [char](6) NULL,
	[CLIENTE2] [int] NULL,
	[NOME_CLIENTE] [varchar](50) NULL,
	[GRUPO] [char](6) NULL,
	[CEP] [varchar](8) NULL,
	[VENDEDOR] [char](6) NULL,
	[NOME_VENDEDOR] [varchar](30) NULL,
	[CUSTO] [numeric](9, 2) NULL,
	[PRODUTOS] [numeric](9, 2) NULL,
	[DESCONTO] [numeric](9, 2) NULL,
	[DESCONTO2] [numeric](9, 2) NULL,
	[FRETE] [numeric](9, 2) NULL,
	[BONIFICAR] [numeric](9, 2) NULL,
	[TOTAL] [numeric](9, 2) NULL,
	[BLOQUEIO] [numeric](9, 2) NULL,
	[COMISSAO] [numeric](9, 2) NULL,
	[COMISSAO2] [numeric](9, 2) NULL,
	[PAGTO] [numeric](9, 2) NULL,
	[PAGTO_DESC] [varchar](35) NULL,
	[PAGTO_FORMA] [char](3) NULL,
	[PAGTO_COND] [char](3) NULL,
	[PAGTO_PARCELAS] [int] NULL,
	[PAGTO_OPERADORA] [varchar](30) NULL,
	[PAGTO_CARTAO] [varchar](16) NULL,
	[PAGTO_FATOR] [numeric](9, 2) NULL,
	[PAGTO_COMISSAO] [numeric](9, 2) NULL,
	[PESO] [numeric](9, 3) NULL,
	[TIPO_FRETE] [char](3) NULL,
	[TRANSP] [char](6) NULL,
	[NOME_TRANSP] [varchar](30) NULL,
	[OBS] [varchar](1000) NULL,
	[OBS_DANFE] [varchar](1000) NULL,
	[OBS_LIB] [varchar](1000) NULL,
	[PARC01] [numeric](9, 2) NULL,
	[PARC02] [numeric](9, 2) NULL,
	[PARC03] [numeric](9, 2) NULL,
	[PARC04] [numeric](9, 2) NULL,
	[PARC05] [numeric](9, 2) NULL,
	[PARC06] [numeric](9, 2) NULL,
	[PARC07] [numeric](9, 2) NULL,
	[PARC08] [numeric](9, 2) NULL,
	[PARC09] [numeric](9, 2) NULL,
	[PARC10] [numeric](9, 2) NULL,
	[PARC11] [numeric](9, 2) NULL,
	[PARC12] [numeric](9, 2) NULL,
	[VENC01] [datetime] NULL,
	[VENC02] [datetime] NULL,
	[VENC03] [datetime] NULL,
	[VENC04] [datetime] NULL,
	[VENC05] [datetime] NULL,
	[VENC06] [datetime] NULL,
	[VENC07] [datetime] NULL,
	[VENC08] [datetime] NULL,
	[VENC09] [datetime] NULL,
	[VENC10] [datetime] NULL,
	[VENC11] [datetime] NULL,
	[VENC12] [datetime] NULL,
	[EVENTO] [char](10) NULL,
	[LIB_DATA] [datetime] NULL,
	[LIB_HORA] [char](8) NULL,
	[LIB_USUARIO] [int] NULL,
	[LIB_NOME] [varchar](20) NULL,
	[LIB_TOTAL] [numeric](9, 2) NULL,
	[LIB_SALDO] [numeric](9, 2) NULL,
	[ESTORNADO] [datetime] NULL,
	[VISUALIZADO] [char](1) NULL,
	[BLOQUEIO2] [char](1) NULL,
	[PAGTO_COD] [int] NULL,
	[VALIDADE] [datetime] NULL,
	[PAGTO_PRAZO] [int] NULL,
	[ORIGEM] [int] NULL,
	[ENCOMENDA] [char](1) NULL,
	[MA_TOTAL] [numeric](9, 2) NULL,
	[MA_CUSTO] [numeric](9, 2) NULL,
	[MA_CUSTO2] [numeric](9, 2) NULL,
	[MA_CUSTO3] [numeric](9, 2) NULL,
	[MA_CUSTOF] [numeric](9, 2) NULL,
	[MA_FRETE] [numeric](9, 2) NULL,
	[MA_COMISSAO] [numeric](9, 2) NULL,
	[MA_CUSTOF2] [numeric](9, 2) NULL,
	[MA_FRETE2] [numeric](9, 2) NULL,
	[MA_COMISSAO2] [numeric](9, 2) NULL,
 CONSTRAINT [PK_BMAC_PEDIDOS] PRIMARY KEY CLUSTERED 
(
	[PEDIDO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BMAC_PEDIDOS2]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BMAC_PEDIDOS2](
	[PEDIDO] [int] NOT NULL,
	[ITEM] [char](2) NOT NULL,
	[PRODUTO] [varchar](15) NULL,
	[DESCRICAO] [varchar](50) NULL,
	[ARMAZEM] [char](2) NULL,
	[QTDE] [int] NULL,
	[MINIMO] [numeric](9, 2) NULL,
	[MINIMO2] [numeric](9, 2) NULL,
	[TABELA] [numeric](9, 2) NULL,
	[DESCONTO] [numeric](8, 5) NULL,
	[DESCONTO2] [numeric](9, 2) NULL,
	[PAGTO] [numeric](9, 2) NULL,
	[UNITARIO] [numeric](9, 2) NULL,
	[TOTAL] [numeric](9, 2) NULL,
	[BLOQUEIO] [numeric](9, 2) NULL,
	[BASE] [numeric](9, 2) NULL,
	[COMISSAO1] [numeric](9, 2) NULL,
	[COMISSAO2] [numeric](9, 2) NULL,
	[COMISSAO3] [numeric](9, 2) NULL,
	[COMISSAO] [numeric](9, 2) NULL,
	[TOTAL_COMISSAO] [numeric](9, 2) NULL,
	[TOTAL_COMISSAO2] [numeric](9, 2) NULL,
	[PESO] [numeric](9, 3) NULL,
	[PESO_TOTAL] [numeric](9, 3) NULL,
	[OBS] [varchar](80) NULL,
	[BONIFICAR] [char](1) NULL,
	[PROMOCAO] [int] NULL,
	[PROMOCAO_UNIT] [numeric](9, 2) NULL,
	[PROMOCAO_TOTAL] [numeric](9, 2) NULL,
	[BLOQUEIO2] [char](1) NULL,
	[FORNECEDOR] [char](6) NULL,
	[CUSTO] [numeric](9, 2) NULL,
	[MA_TOTAL] [numeric](9, 2) NULL,
	[MA_CUSTO] [numeric](9, 2) NULL,
	[MA_CUSTO2] [numeric](9, 2) NULL,
	[MA_CUSTO3] [numeric](9, 2) NULL,
	[MA_CUSTOF] [numeric](9, 2) NULL,
	[MA_FRETE] [numeric](9, 2) NULL,
	[MA_COMISSAO] [numeric](9, 2) NULL,
 CONSTRAINT [PK_BMAC_PEDIDOS2] PRIMARY KEY CLUSTERED 
(
	[PEDIDO] ASC,
	[ITEM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BMAC_PROMOCOES]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BMAC_PROMOCOES](
	[PROMOCAO] [int] NOT NULL,
	[CAMPANHA] [int] NULL,
	[GRUPO] [char](6) NULL,
	[DESCRICAO] [varchar](30) NULL,
	[PRODUTO] [varchar](15) NOT NULL,
	[PRECO] [numeric](9, 2) NULL,
	[QTDE1] [int] NULL,
	[QTDE2] [int] NULL,
	[ESTOQUE] [int] NULL,
	[LIMITE] [int] NULL,
	[COMISSAO] [numeric](5, 2) NULL,
	[TOTAL] [numeric](9, 2) NULL,
	[VALIDADE] [datetime] NULL,
	[ATIVO] [char](1) NULL,
 CONSTRAINT [PK_BMAC_PROMOCOES] PRIMARY KEY CLUSTERED 
(
	[PROMOCAO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BMAC_RASCUNHO]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BMAC_RASCUNHO](
	[CLIENTE] [char](6) NOT NULL,
	[RASCUNHO] [text] NULL,
 CONSTRAINT [PK_BMAC_RASCUNHO] PRIMARY KEY CLUSTERED 
(
	[CLIENTE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BMAC_REDUCAO]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BMAC_REDUCAO](
	[GRUPO] [char](6) NOT NULL,
	[VENDEDOR] [char](6) NOT NULL,
	[PRAZO_DE] [int] NOT NULL,
	[PRAZO_ATE] [nchar](10) NOT NULL,
	[DESCONTO_DE] [numeric](5, 2) NOT NULL,
	[DESCONTO_ATE] [numeric](5, 2) NOT NULL,
	[COMISSAO] [numeric](5, 2) NOT NULL,
 CONSTRAINT [PK_BMAC_REDUCAO2] PRIMARY KEY CLUSTERED 
(
	[GRUPO] ASC,
	[VENDEDOR] ASC,
	[PRAZO_DE] ASC,
	[PRAZO_ATE] ASC,
	[DESCONTO_DE] ASC,
	[DESCONTO_ATE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BMAC_USUARIOS]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BMAC_USUARIOS](
	[FILIAL] [char](2) NULL,
	[USUARIO] [int] NOT NULL,
	[NOME] [varchar](20) NULL,
	[SOBRENOME] [varchar](30) NULL,
	[LOGIN] [varchar](20) NULL,
	[SENHA] [varchar](10) NULL,
	[VENDEDOR] [varchar](100) NULL,
	[ADMIN] [char](1) NULL,
	[SUPERVISOR] [char](1) NULL,
	[NOVIDADES] [datetime] NULL,
	[ARMAZEM] [char](2) NULL,
	[EMAIL] [varchar](200) NULL,
	[EMAIL_USUARIO] [varchar](200) NULL,
	[EMAIL_SENHA] [varchar](50) NULL,
	[EXTERNO] [char](1) NULL,
	[ATIVO] [char](1) NULL,
	[REATIVACAO] [char](1) NULL,
 CONSTRAINT [PK_BMAC_USUARIOS] PRIMARY KEY CLUSTERED 
(
	[USUARIO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BMAC_VENDAS]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BMAC_VENDAS](
	[FILIAL] [char](2) NOT NULL,
	[CLIENTE] [char](6) NULL,
	[VENDEDOR] [char](6) NULL,
	[GRUPOCLI] [char](6) NULL,
	[EMISSAO] [char](8) NULL,
	[ANO] [char](4) NULL,
	[MES] [char](2) NULL,
	[HORA] [char](8) NULL,
	[SERIE] [char](3) NOT NULL,
	[DOC] [char](9) NOT NULL,
	[PEDIDO] [char](6) NULL,
	[PRODUTO] [varchar](15) NULL,
	[ITEM] [char](2) NOT NULL,
	[GRUPOPRO] [char](4) NULL,
	[QTDE] [int] NULL,
	[CUSTO] [decimal](11, 2) NULL,
	[UNITARIO] [float] NULL,
	[TOTAL] [decimal](11, 2) NULL,
	[FRETE] [char](1) NULL,
	[PAGTO] [char](3) NULL,
	[PARCELAS] [int] NULL,
	[SALDO] [float] NULL,
	[RECNO] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BMAC_VENDAS2]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BMAC_VENDAS2](
	[CLIENTE] [char](6) NOT NULL,
	[PRODUTO] [varchar](15) NOT NULL,
	[QTDE] [int] NULL,
	[ULTIMA] [char](8) NULL,
 CONSTRAINT [PK_BMAC_VENDAS2] PRIMARY KEY CLUSTERED 
(
	[CLIENTE] ASC,
	[PRODUTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BMAC_XCLIENTES]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BMAC_XCLIENTES](
	[FILIAL] [char](2) NOT NULL,
	[CLIENTE] [char](6) NOT NULL,
	[NOME] [varchar](50) NULL,
	[GRUPO] [char](6) NULL,
	[VENDEDOR] [char](6) NULL,
	[PRIMEIRA] [datetime] NULL,
	[ULTIMA] [datetime] NULL,
	[RECENCIA] [int] NULL,
	[FREQUENCIA] [int] NULL,
	[FREQUENCIAM] [int] NULL,
	[VALOR] [decimal](11, 2) NULL,
	[INTERVALO] [int] NULL,
	[FAT_MEDIO] [decimal](11, 2) NULL,
	[FAT_ATUAL] [decimal](11, 2) NULL,
	[PEDIDO_PRODUTOS] [int] NULL,
	[PEDIDO_VALOR] [decimal](11, 2) NULL,
	[FINANCEIRO] [varchar](20) NULL,
	[DIAS_ATRASO] [int] NULL,
	[TIPO] [int] NULL,
	[ORDEM] [int] NULL,
	[ESPECIALIDADE] [varchar](30) NULL,
 CONSTRAINT [PK_BMAC_XCLIENTES] PRIMARY KEY CLUSTERED 
(
	[FILIAL] ASC,
	[CLIENTE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BMAC_XVENDAS]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BMAC_XVENDAS](
	[FILIAL] [char](2) NOT NULL,
	[CLIENTE] [char](6) NULL,
	[VENDEDOR] [char](6) NULL,
	[EMISSAO] [char](8) NULL,
	[ANO] [char](4) NULL,
	[MES] [char](2) NULL,
	[SERIE] [char](3) NOT NULL,
	[DOC] [char](9) NOT NULL,
	[PEDIDO] [char](6) NULL,
	[PRODUTO] [varchar](15) NULL,
	[ITEM] [char](2) NOT NULL,
	[GRUPOPRO] [char](4) NULL,
	[QTDE] [int] NULL,
	[UNITARIO] [float] NULL,
	[TOTAL] [decimal](11, 2) NULL,
	[FATURADO] [decimal](11, 2) NULL,
	[RECNO] [int] NULL,
	[CLIENTE2] [char](6) NULL,
	[ANTERIOR] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SA1010]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SA1010](
	[A1_FILIAL] [varchar](2) NOT NULL,
	[A1_COD] [varchar](6) NOT NULL,
	[A1_LOJA] [varchar](2) NOT NULL,
	[A1_NOME] [varchar](40) NOT NULL,
	[A1_PESSOA] [varchar](1) NOT NULL,
	[A1_NREDUZ] [varchar](20) NOT NULL,
	[A1_END] [varchar](40) NOT NULL,
	[A1_TIPO] [varchar](1) NOT NULL,
	[A1_EST] [varchar](2) NOT NULL,
	[A1_ESTADO] [varchar](20) NOT NULL,
	[A1_COD_MUN] [varchar](5) NOT NULL,
	[A1_MUN] [varchar](25) NOT NULL,
	[A1_NATUREZ] [varchar](10) NOT NULL,
	[A1_BAIRRO] [varchar](30) NOT NULL,
	[A1_CEP] [varchar](8) NOT NULL,
	[A1_DDI] [varchar](6) NOT NULL,
	[A1_DDD] [varchar](3) NOT NULL,
	[A1_TEL] [varchar](15) NOT NULL,
	[A1_TELEX] [varchar](10) NOT NULL,
	[A1_FAX] [varchar](15) NOT NULL,
	[A1_ENDCOB] [varchar](40) NOT NULL,
	[A1_PAIS] [varchar](3) NOT NULL,
	[A1_ENDENT] [varchar](40) NOT NULL,
	[A1_ENDREC] [varchar](40) NOT NULL,
	[A1_CONTATO] [varchar](15) NOT NULL,
	[A1_CGC] [varchar](14) NOT NULL,
	[A1_INSCR] [varchar](18) NOT NULL,
	[A1_PFISICA] [varchar](18) NOT NULL,
	[A1_INSCRM] [varchar](18) NOT NULL,
	[A1_VEND] [varchar](6) NOT NULL,
	[A1_COMIS] [float] NOT NULL,
	[A1_REGIAO] [varchar](3) NOT NULL,
	[A1_CONTA] [varchar](20) NOT NULL,
	[A1_BCO1] [varchar](3) NOT NULL,
	[A1_BCO2] [varchar](3) NOT NULL,
	[A1_BCO3] [varchar](3) NOT NULL,
	[A1_BCO4] [varchar](3) NOT NULL,
	[A1_BCO5] [varchar](3) NOT NULL,
	[A1_TRANSP] [varchar](6) NOT NULL,
	[A1_TPFRET] [varchar](1) NOT NULL,
	[A1_COND] [varchar](3) NOT NULL,
	[A1_DESC] [float] NOT NULL,
	[A1_PRIOR] [varchar](1) NOT NULL,
	[A1_RISCO] [varchar](1) NOT NULL,
	[A1_LC] [float] NOT NULL,
	[A1_VENCLC] [varchar](8) NOT NULL,
	[A1_CLASSE] [varchar](1) NOT NULL,
	[A1_LCFIN] [float] NOT NULL,
	[A1_MOEDALC] [float] NOT NULL,
	[A1_MSALDO] [float] NOT NULL,
	[A1_MCOMPRA] [float] NOT NULL,
	[A1_METR] [float] NOT NULL,
	[A1_PRICOM] [varchar](8) NOT NULL,
	[A1_ULTCOM] [varchar](8) NOT NULL,
	[A1_NROCOM] [float] NOT NULL,
	[A1_FORMVIS] [varchar](3) NOT NULL,
	[A1_TEMVIS] [float] NOT NULL,
	[A1_ULTVIS] [varchar](8) NOT NULL,
	[A1_TMPVIS] [varchar](5) NOT NULL,
	[A1_TMPSTD] [varchar](5) NOT NULL,
	[A1_CLASVEN] [varchar](1) NOT NULL,
	[A1_MENSAGE] [varchar](3) NOT NULL,
	[A1_SALDUP] [float] NOT NULL,
	[A1_RECISS] [varchar](1) NOT NULL,
	[A1_NROPAG] [float] NOT NULL,
	[A1_SALPEDL] [float] NOT NULL,
	[A1_TRANSF] [varchar](1) NOT NULL,
	[A1_SUFRAMA] [varchar](12) NOT NULL,
	[A1_ATR] [float] NOT NULL,
	[A1_VACUM] [float] NOT NULL,
	[A1_SALPED] [float] NOT NULL,
	[A1_TITPROT] [float] NOT NULL,
	[A1_DTULTIT] [varchar](8) NOT NULL,
	[A1_CHQDEVO] [float] NOT NULL,
	[A1_DTULCHQ] [varchar](8) NOT NULL,
	[A1_MATR] [float] NOT NULL,
	[A1_MAIDUPL] [float] NOT NULL,
	[A1_TABELA] [varchar](3) NOT NULL,
	[A1_INCISS] [varchar](1) NOT NULL,
	[A1_SALDUPM] [float] NOT NULL,
	[A1_PAGATR] [float] NOT NULL,
	[A1_CXPOSTA] [varchar](20) NOT NULL,
	[A1_ATIVIDA] [varchar](7) NOT NULL,
	[A1_CARGO1] [varchar](15) NOT NULL,
	[A1_CARGO2] [varchar](15) NOT NULL,
	[A1_CARGO3] [varchar](15) NOT NULL,
	[A1_SUPER] [varchar](6) NOT NULL,
	[A1_RTEC] [varchar](6) NOT NULL,
	[A1_ALIQIR] [float] NOT NULL,
	[A1_OBSERV] [varchar](40) NOT NULL,
	[A1_RG] [varchar](15) NOT NULL,
	[A1_CALCSUF] [varchar](1) NOT NULL,
	[A1_DTNASC] [varchar](8) NOT NULL,
	[A1_SALPEDB] [float] NOT NULL,
	[A1_CLIFAT] [varchar](6) NOT NULL,
	[A1_GRPTRIB] [varchar](3) NOT NULL,
	[A1_BAIRROC] [varchar](30) NOT NULL,
	[A1_CEPC] [varchar](8) NOT NULL,
	[A1_MUNC] [varchar](15) NOT NULL,
	[A1_ESTC] [varchar](2) NOT NULL,
	[A1_BAIRROE] [varchar](20) NOT NULL,
	[A1_CEPE] [varchar](8) NOT NULL,
	[A1_MUNE] [varchar](15) NOT NULL,
	[A1_ESTE] [varchar](2) NOT NULL,
	[A1_SATIV1] [varchar](6) NOT NULL,
	[A1_SATIV2] [varchar](6) NOT NULL,
	[A1_CODPAIS] [varchar](5) NOT NULL,
	[A1_TPESSOA] [varchar](2) NOT NULL,
	[A1_CODLOC] [varchar](8) NOT NULL,
	[A1_TPISSRS] [varchar](2) NOT NULL,
	[A1_SATIV3] [varchar](6) NOT NULL,
	[A1_SATIV4] [varchar](6) NOT NULL,
	[A1_SATIV5] [varchar](6) NOT NULL,
	[A1_SATIV6] [varchar](6) NOT NULL,
	[A1_SATIV7] [varchar](6) NOT NULL,
	[A1_SATIV8] [varchar](6) NOT NULL,
	[A1_CODMARC] [varchar](6) NOT NULL,
	[A1_CODAGE] [varchar](3) NOT NULL,
	[A1_COMAGE] [float] NOT NULL,
	[A1_TIPCLI] [varchar](1) NOT NULL,
	[A1_EMAIL] [varchar](60) NOT NULL,
	[A1_DEST_1] [varchar](3) NOT NULL,
	[A1_DEST_2] [varchar](3) NOT NULL,
	[A1_CODMUN] [varchar](5) NOT NULL,
	[A1_HPAGE] [varchar](30) NOT NULL,
	[A1_DEST_3] [varchar](3) NOT NULL,
	[A1_CBO] [varchar](7) NOT NULL,
	[A1_CNAE] [varchar](9) NOT NULL,
	[A1_CONDPAG] [varchar](5) NOT NULL,
	[A1_DIASPAG] [float] NOT NULL,
	[A1_OBS] [varchar](6) NOT NULL,
	[A1_AGREG] [varchar](4) NOT NULL,
	[A1_CODHIST] [varchar](6) NOT NULL,
	[A1_RECINSS] [varchar](1) NOT NULL,
	[A1_RECCOFI] [varchar](1) NOT NULL,
	[A1_RECCSLL] [varchar](1) NOT NULL,
	[A1_RECPIS] [varchar](1) NOT NULL,
	[A1_TIPPER] [varchar](2) NOT NULL,
	[A1_SALFIN] [float] NOT NULL,
	[A1_SALFINM] [float] NOT NULL,
	[A1_CONTAB] [varchar](15) NOT NULL,
	[A1_B2B] [varchar](1) NOT NULL,
	[A1_GRPVEN] [varchar](6) NOT NULL,
	[A1_CLICNV] [varchar](1) NOT NULL,
	[A1_MSBLQL] [varchar](1) NOT NULL,
	[A1_INSCRUR] [varchar](18) NOT NULL,
	[A1_SITUA] [varchar](2) NOT NULL,
	[A1_NUMRA] [varchar](15) NOT NULL,
	[A1_SUBCOD] [varchar](1) NOT NULL,
	[A1_CDRDES] [varchar](6) NOT NULL,
	[A1_FILDEB] [varchar](2) NOT NULL,
	[A1_CODFOR] [varchar](15) NOT NULL,
	[A1_ABICS] [varchar](4) NOT NULL,
	[A1_BLEMAIL] [varchar](1) NOT NULL,
	[A1_TIPOCLI] [varchar](2) NOT NULL,
	[A1_VINCULO] [varchar](2) NOT NULL,
	[A1_DTINIV] [varchar](8) NOT NULL,
	[A1_DTFIMV] [varchar](8) NOT NULL,
	[A1_LOCCONS] [varchar](2) NOT NULL,
	[A1_PERFIL] [float] NOT NULL,
	[A1_HRTRANS] [varchar](5) NOT NULL,
	[A1_UNIDVEN] [varchar](6) NOT NULL,
	[A1_SIMPLES] [varchar](1) NOT NULL,
	[A1_CEINSS] [varchar](14) NOT NULL,
	[A1_FRETISS] [varchar](1) NOT NULL,
	[A1_CTARE] [varchar](1) NOT NULL,
	[A1_ABATIMP] [varchar](1) NOT NULL,
	[A1_RECIRRF] [varchar](1) NOT NULL,
	[A1_TIMEKEE] [varchar](8) NOT NULL,
	[A1_CONTRIB] [varchar](1) NOT NULL,
	[A1_COMPLEM] [varchar](50) NOT NULL,
	[A1_FOMEZER] [varchar](1) NOT NULL,
	[A1_RECFET] [varchar](1) NOT NULL,
	[D_E_L_E_T_] [varchar](1) NOT NULL,
	[R_E_C_N_O_] [int] NOT NULL,
	[R_E_C_D_E_L_] [int] NOT NULL,
	[A1_SIMPNAC] [varchar](1) NOT NULL,
	[A1_CODSIAF] [varchar](4) NOT NULL,
	[A1_PRSTSER] [varchar](1) NOT NULL,
	[A1_ALIFIXA] [varchar](1) NOT NULL,
	[A1_ENDNOT] [varchar](1) NOT NULL,
	[A1_X_JRCOM] [varchar](1) NOT NULL,
	[A1_X_COMZ] [varchar](1) NOT NULL,
	[A1_X_DTINC] [varchar](8) NOT NULL,
	[A1_X_HRINC] [varchar](8) NOT NULL,
	[A1_X_USINC] [varchar](20) NOT NULL,
	[A1_X_CODFR] [varchar](7) NOT NULL,
	[A1_X_DTCAD] [varchar](8) NOT NULL,
	[A1_X_ALERT] [varchar](100) NOT NULL,
	[A1_X_ATEND] [float] NOT NULL,
	[A1_X_FORMA] [varchar](3) NOT NULL,
	[A1_X_CBAN] [varchar](1) NOT NULL,
	[A1_X_AGCN] [varchar](1) NOT NULL,
	[A1_X_CLBOL] [varchar](6) NOT NULL,
	[A1_X_LJBOL] [varchar](2) NOT NULL,
	[A1_X_TARBC] [varchar](1) NOT NULL,
	[A1_X_PROT] [varchar](1) NOT NULL,
	[A1_X_VEND2] [varchar](6) NOT NULL,
	[A1_X_VEND3] [varchar](6) NOT NULL,
	[A1_X_TEL] [varchar](50) NOT NULL,
	[A1_X_LOGBL] [varchar](60) NOT NULL,
	[A1_X_TES] [varchar](3) NOT NULL,
	[A1__BLQAVU] [varchar](1) NOT NULL,
	[A1_X_IMPNE] [varchar](1) NOT NULL,
	[A1__GERFAT] [varchar](1) NOT NULL,
	[A1_X_USUFR] [varchar](6) NOT NULL,
	[A1_X_DFIN] [float] NOT NULL,
	[A1_X_DTAB] [float] NOT NULL,
	[A1_REGPB] [varchar](1) NOT NULL,
	[A1_RFACS] [varchar](1) NOT NULL,
	[A1_RFABOV] [varchar](1) NOT NULL,
	[A1_INCULT] [varchar](1) NOT NULL,
	[A1_X_IMPBO] [varchar](1) NOT NULL,
	[A1_X_VENDA] [varchar](6) NOT NULL,
	[A1_IPWEB] [varchar](20) NOT NULL,
	[A1_CRDMA] [varchar](1) NOT NULL,
	[A1_ENTID] [varchar](2) NOT NULL,
	[A1_USADDA] [varchar](1) NOT NULL,
	[A1_MINIRF] [varchar](1) NOT NULL,
	[A1_X_SERAS] [varchar](1) NOT NULL,
	[A1_REGESIM] [varchar](1) NOT NULL,
	[A1_PERCATM] [float] NOT NULL,
	[A1_INDRET] [varchar](2) NOT NULL,
	[A1_X_AGLPD] [varchar](1) NOT NULL,
	[A1_X_MSN] [varchar](80) NOT NULL,
	[A1_X_CONT] [varchar](80) NOT NULL,
	[A1_X_PROF] [varchar](1) NOT NULL,
	[A1_X_CRO] [varchar](10) NOT NULL,
	[A1_X_UFCRO] [varchar](2) NOT NULL,
	[A1_X_VECRO] [varchar](1) NOT NULL,
	[A1_TPJ] [varchar](1) NOT NULL,
	[A1_TRIBFAV] [varchar](1) NOT NULL,
	[A1_PERFECP] [float] NOT NULL,
	[A1_OUTRMUN] [varchar](10) NOT NULL,
	[A1_TPNFSE] [varchar](2) NOT NULL,
	[A1_IRBAX] [varchar](1) NOT NULL,
	[A1_FILTRF] [varchar](2) NOT NULL,
	[A1_TDA] [varchar](1) NOT NULL,
	[A1_IBGE] [varchar](11) NOT NULL,
	[A1_CBAIRRE] [varchar](6) NOT NULL,
	[A1_CODMUNE] [varchar](5) NOT NULL,
	[A1_TIPPRFL] [varchar](1) NOT NULL,
	[A1_PRF_VLD] [varchar](8) NOT NULL,
	[A1_PRF_COD] [varchar](6) NOT NULL,
	[A1_PRF_OBS] [image] NULL,
	[A1_CODFID] [varchar](40) NOT NULL,
	[A1_ORIGEM] [varchar](2) NOT NULL,
	[A1_TPDP] [varchar](1) NOT NULL,
	[A1_X_SERA2] [varchar](1) NOT NULL,
	[A1_X_OPER] [varchar](2) NOT NULL,
	[A1_X_LCA] [varchar](1) NOT NULL,
	[A1_INOVAUT] [varchar](1) NOT NULL,
	[A1_X_WORK1] [varchar](1) NOT NULL,
	[A1_X_WORK2] [varchar](1) NOT NULL,
	[A1_X_GRPV] [varchar](6) NOT NULL,
	[A1_X_ESPEC] [varchar](30) NOT NULL,
	[A1_X_PRADO] [float] NOT NULL,
	[A1_RECFMD] [varchar](1) NOT NULL,
	[A1_IDHIST] [varchar](20) NOT NULL,
	[A1_NIF] [varchar](40) NOT NULL,
	[A1_MATFUN] [varchar](6) NOT NULL,
	[A1_IENCONT] [varchar](1) NOT NULL,
	[A1_X_VLDSE] [varchar](8) NOT NULL,
	[A1_INCLTMG] [varchar](1) NOT NULL,
	[A1_RFUNDES] [varchar](1) NOT NULL,
	[A1_RIMAMT] [varchar](1) NOT NULL,
	[A1_RFASEMT] [varchar](1) NOT NULL,
 CONSTRAINT [SA1010_PK] PRIMARY KEY CLUSTERED 
(
	[R_E_C_N_O_] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SA2010]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SA2010](
	[A2_FILIAL] [varchar](2) NOT NULL,
	[A2_COD] [varchar](6) NOT NULL,
	[A2_LOJA] [varchar](2) NOT NULL,
	[A2_NOME] [varchar](40) NOT NULL,
	[A2_NREDUZ] [varchar](20) NOT NULL,
	[A2_END] [varchar](40) NOT NULL,
	[A2_NR_END] [varchar](6) NOT NULL,
	[A2_BAIRRO] [varchar](20) NOT NULL,
	[A2_EST] [varchar](2) NOT NULL,
	[A2_ESTADO] [varchar](20) NOT NULL,
	[A2_COD_MUN] [varchar](5) NOT NULL,
	[A2_MUN] [varchar](15) NOT NULL,
	[A2_CEP] [varchar](8) NOT NULL,
	[A2_CX_POST] [varchar](5) NOT NULL,
	[A2_TIPO] [varchar](1) NOT NULL,
	[A2_CGC] [varchar](14) NOT NULL,
	[A2_PFISICA] [varchar](18) NOT NULL,
	[A2_DDI] [varchar](6) NOT NULL,
	[A2_DDD] [varchar](3) NOT NULL,
	[A2_TEL] [varchar](50) NOT NULL,
	[A2_FAX] [varchar](15) NOT NULL,
	[A2_INSCR] [varchar](18) NOT NULL,
	[A2_INSCRM] [varchar](18) NOT NULL,
	[A2_CONTATO] [varchar](15) NOT NULL,
	[A2_BANCO] [varchar](3) NOT NULL,
	[A2_AGENCIA] [varchar](5) NOT NULL,
	[A2_NUMCON] [varchar](10) NOT NULL,
	[A2_SWIFT] [varchar](30) NOT NULL,
	[A2_NATUREZ] [varchar](10) NOT NULL,
	[A2_TRANSP] [varchar](6) NOT NULL,
	[A2_PRIOR] [varchar](1) NOT NULL,
	[A2_RISCO] [varchar](3) NOT NULL,
	[A2_COND] [varchar](3) NOT NULL,
	[A2_LC] [varchar](14) NOT NULL,
	[A2_MATR] [float] NOT NULL,
	[A2_MCOMPRA] [float] NOT NULL,
	[A2_METR] [float] NOT NULL,
	[A2_MSALDO] [float] NOT NULL,
	[A2_NROCOM] [float] NOT NULL,
	[A2_PRICOM] [varchar](8) NOT NULL,
	[A2_ULTCOM] [varchar](8) NOT NULL,
	[A2_SALDUP] [float] NOT NULL,
	[A2_DESVIO] [float] NOT NULL,
	[A2_SALDUPM] [float] NOT NULL,
	[A2_CONTA] [varchar](20) NOT NULL,
	[A2_TIPORUR] [varchar](1) NOT NULL,
	[A2_RECISS] [varchar](1) NOT NULL,
	[A2_PAIS] [varchar](3) NOT NULL,
	[A2_DEPTO] [varchar](30) NOT NULL,
	[A2_ID_FBFN] [varchar](7) NOT NULL,
	[A2_STATUS] [varchar](1) NOT NULL,
	[A2_GRUPO] [varchar](3) NOT NULL,
	[A2_ATIVIDA] [varchar](7) NOT NULL,
	[A2_ORIG_1] [varchar](3) NOT NULL,
	[A2_ORIG_2] [varchar](3) NOT NULL,
	[A2_ORIG_3] [varchar](3) NOT NULL,
	[A2_VINCULA] [varchar](1) NOT NULL,
	[A2_REPRES] [varchar](52) NOT NULL,
	[A2_REPCONT] [varchar](50) NOT NULL,
	[A2_REPRTEL] [varchar](50) NOT NULL,
	[A2_REPRFAX] [varchar](30) NOT NULL,
	[A2_REPR_EM] [varchar](30) NOT NULL,
	[A2_REPR_EN] [varchar](52) NOT NULL,
	[A2_REPBAIR] [varchar](30) NOT NULL,
	[A2_REPRMUN] [varchar](30) NOT NULL,
	[A2_REPREST] [varchar](2) NOT NULL,
	[A2_REPRCEP] [varchar](8) NOT NULL,
	[A2_REPPAIS] [varchar](3) NOT NULL,
	[A2_ID_REPR] [varchar](1) NOT NULL,
	[A2_REPR_BA] [varchar](3) NOT NULL,
	[A2_REPR_AG] [varchar](5) NOT NULL,
	[A2_REPR_CO] [varchar](10) NOT NULL,
	[A2_REPRCGC] [varchar](14) NOT NULL,
	[A2_RET_PAI] [varchar](1) NOT NULL,
	[A2_COMI_SO] [varchar](1) NOT NULL,
	[A2_EMAIL] [varchar](60) NOT NULL,
	[A2_HPAGE] [varchar](30) NOT NULL,
	[A2_CODMUN] [varchar](5) NOT NULL,
	[A2_CONTCOM] [varchar](15) NOT NULL,
	[A2_FATAVA] [float] NOT NULL,
	[A2_FABRICA] [varchar](1) NOT NULL,
	[A2_DTAVA] [varchar](8) NOT NULL,
	[A2_DTVAL] [varchar](8) NOT NULL,
	[A2_OK] [varchar](2) NOT NULL,
	[A2_RECINSS] [varchar](1) NOT NULL,
	[A2_TELEX] [varchar](10) NOT NULL,
	[A2_CODLOC] [varchar](8) NOT NULL,
	[A2_CODPAIS] [varchar](5) NOT NULL,
	[A2_TPESSOA] [varchar](2) NOT NULL,
	[A2_TPISSRS] [varchar](2) NOT NULL,
	[A2_MNOTA] [float] NOT NULL,
	[A2_RECCIDE] [varchar](1) NOT NULL,
	[A2_GRPTRIB] [varchar](3) NOT NULL,
	[A2_UNFEDRP] [varchar](30) NOT NULL,
	[A2_CONTAB] [varchar](15) NOT NULL,
	[A2_CLIQF] [varchar](15) NOT NULL,
	[A2_PLGRUPO] [varchar](3) NOT NULL,
	[A2_CODBLO] [varchar](3) NOT NULL,
	[A2_PAISORI] [varchar](20) NOT NULL,
	[A2_ROYALTY] [varchar](1) NOT NULL,
	[A2_TXTRIBU] [float] NOT NULL,
	[A2_B2B] [varchar](1) NOT NULL,
	[A2_PLCRRES] [varchar](1) NOT NULL,
	[A2_PLFIL] [varchar](1) NOT NULL,
	[A2_SIGLCR] [varchar](7) NOT NULL,
	[A2_CONREG] [varchar](10) NOT NULL,
	[A2_DATBLO] [varchar](8) NOT NULL,
	[A2_PLPEDES] [float] NOT NULL,
	[A2_CBO] [varchar](7) NOT NULL,
	[A2_CNAE] [varchar](9) NOT NULL,
	[A2_CIVIL] [varchar](1) NOT NULL,
	[A2_ROYMIN] [float] NOT NULL,
	[A2_SATIV1] [varchar](6) NOT NULL,
	[A2_PAGAMEN] [varchar](1) NOT NULL,
	[A2_ENDCOMP] [varchar](21) NOT NULL,
	[A2_MSBLQL] [varchar](1) NOT NULL,
	[A2_GRPDEP] [varchar](5) NOT NULL,
	[A2_SUBCOD] [varchar](1) NOT NULL,
	[A2_TIPAWB] [varchar](1) NOT NULL,
	[A2_RECSEST] [varchar](1) NOT NULL,
	[A2_FILDEB] [varchar](2) NOT NULL,
	[A2_RECPIS] [varchar](1) NOT NULL,
	[A2_RECCOFI] [varchar](1) NOT NULL,
	[A2_RECCSLL] [varchar](1) NOT NULL,
	[A2_ABICS] [varchar](4) NOT NULL,
	[A2_CODFAV] [varchar](6) NOT NULL,
	[A2_LOJFAV] [varchar](2) NOT NULL,
	[A2_NUMDEP] [float] NOT NULL,
	[A2_CALCIRF] [varchar](1) NOT NULL,
	[A2_VINCULO] [varchar](2) NOT NULL,
	[A2_DTINIV] [varchar](8) NOT NULL,
	[A2_DTFIMV] [varchar](8) NOT NULL,
	[A2_RECFET] [varchar](1) NOT NULL,
	[A2_NUMRA] [varchar](6) NOT NULL,
	[A2_CODINSS] [varchar](11) NOT NULL,
	[A2_CTARE] [varchar](1) NOT NULL,
	[A2_COMPLEM] [varchar](50) NOT NULL,
	[A2_FOMEZER] [varchar](1) NOT NULL,
	[A2_FRETISS] [varchar](1) NOT NULL,
	[D_E_L_E_T_] [varchar](1) NOT NULL,
	[R_E_C_N_O_] [int] NOT NULL,
	[R_E_C_D_E_L_] [int] NOT NULL,
	[A2_X_CDANT] [varchar](6) NOT NULL,
	[A2_CODSIAF] [varchar](4) NOT NULL,
	[A2_PRSTSER] [varchar](1) NOT NULL,
	[A2_SIMPNAC] [varchar](1) NOT NULL,
	[A2_INSCMU] [varchar](1) NOT NULL,
	[A2_ENDNOT] [varchar](1) NOT NULL,
	[A2_X_DTINC] [varchar](8) NOT NULL,
	[A2_X_HRINC] [varchar](8) NOT NULL,
	[A2_X_USINC] [varchar](20) NOT NULL,
	[A2_X_DPC] [float] NOT NULL,
	[A2_X_CDPRO] [varchar](1) NOT NULL,
	[A2__BLQREC] [varchar](1) NOT NULL,
	[A2_X_QUALI] [image] NULL,
	[A2_X_VALID] [varchar](8) NOT NULL,
	[A2_IRPROG] [varchar](1) NOT NULL,
	[A2_RFACS] [varchar](1) NOT NULL,
	[A2_RFABOV] [varchar](1) NOT NULL,
	[A2_INCULT] [varchar](1) NOT NULL,
	[A2_CONTPRE] [varchar](1) NOT NULL,
	[A2_CGCEX] [varchar](14) NOT NULL,
	[A2_NEMPR] [varchar](150) NOT NULL,
	[A2_TPCON] [varchar](2) NOT NULL,
	[A2_DTINIR] [varchar](8) NOT NULL,
	[A2_DTFIMR] [varchar](8) NOT NULL,
	[A2_PAISEX] [varchar](3) NOT NULL,
	[A2_NIFEX] [varchar](30) NOT NULL,
	[A2_LOGEX] [varchar](60) NOT NULL,
	[A2_NUMEX] [varchar](6) NOT NULL,
	[A2_COMPLR] [varchar](25) NOT NULL,
	[A2_BAIEX] [varchar](20) NOT NULL,
	[A2_POSEX] [varchar](10) NOT NULL,
	[A2_CIDEX] [varchar](40) NOT NULL,
	[A2_ESTEX] [varchar](40) NOT NULL,
	[A2_TELRE] [varchar](15) NOT NULL,
	[A2_BREEX] [varchar](3) NOT NULL,
	[A2_TPREX] [varchar](3) NOT NULL,
	[A2_TRBEX] [varchar](2) NOT NULL,
	[A2_CPFIRP] [varchar](11) NOT NULL,
	[A2_MINIRF] [varchar](1) NOT NULL,
	[A2_REGESIM] [varchar](1) NOT NULL,
	[A2_INCLTMG] [varchar](1) NOT NULL,
	[A2_X_LIMCO] [float] NOT NULL,
	[A2_X_JAN] [float] NOT NULL,
	[A2_X_FEV] [float] NOT NULL,
	[A2_X_MAR] [float] NOT NULL,
	[A2_X_ABR] [float] NOT NULL,
	[A2_X_MAI] [float] NOT NULL,
	[A2_X_JUN] [float] NOT NULL,
	[A2_X_JUL] [float] NOT NULL,
	[A2_X_AGO] [float] NOT NULL,
	[A2_X_SET] [float] NOT NULL,
	[A2_X_OUT] [float] NOT NULL,
	[A2_X_NOV] [float] NOT NULL,
	[A2_X_DEZ] [float] NOT NULL,
	[A2_TRIBFAV] [varchar](1) NOT NULL,
	[A2_CPOMSP] [varchar](1) NOT NULL,
	[A2_TPLOGR] [varchar](3) NOT NULL,
	[A2_SITESBH] [varchar](1) NOT NULL,
	[A2_TPJ] [varchar](1) NOT NULL,
	[A2_FILTRF] [varchar](2) NOT NULL,
	[A2_APOLICE] [varchar](15) NOT NULL,
	[A2_LOCQUIT] [varchar](1) NOT NULL,
	[A2_STRNTRC] [varchar](1) NOT NULL,
	[A2_RNTRC] [varchar](14) NOT NULL,
	[A2_DTRNTRC] [varchar](8) NOT NULL,
	[A2_TPRNTRC] [varchar](1) NOT NULL,
	[A2_EQPTAC] [varchar](1) NOT NULL,
	[A2_TPCONTA] [varchar](1) NOT NULL,
	[A2_IBGE] [varchar](11) NOT NULL,
	[A2_CODADM] [varchar](3) NOT NULL,
	[A2_IMPIP] [varchar](1) NOT NULL,
	[A2_MJURIDI] [varchar](1) NOT NULL,
	[A2_CONFFIS] [varchar](1) NOT NULL,
	[A2_MUNSC] [varchar](5) NOT NULL,
	[A2_X_TIPO] [varchar](1) NOT NULL,
	[A2_X_REPOR] [float] NOT NULL,
	[A2_CCICMS] [varchar](1) NOT NULL,
	[A2_RESPTRI] [varchar](2) NOT NULL,
	[A2_RECFMD] [varchar](1) NOT NULL,
	[A2_RETISI] [varchar](1) NOT NULL,
	[A2_ISICM] [varchar](1) NOT NULL,
	[A2_IDHIST] [varchar](20) NOT NULL,
	[A2_TIPCTA] [varchar](1) NOT NULL,
	[A2_X_PRAZO] [float] NOT NULL,
	[A2_INOVAUT] [varchar](1) NOT NULL,
	[A2_DTCONV] [varchar](8) NOT NULL,
	[A2_NOMRESP] [varchar](45) NOT NULL,
	[A2_CARGO] [varchar](40) NOT NULL,
	[A2_RFUNDES] [varchar](1) NOT NULL,
	[A2_RIMAMT] [varchar](1) NOT NULL,
	[A2_RFASEMT] [varchar](1) NOT NULL,
	[A2_MINPUB] [varchar](1) NOT NULL,
	[A2_CALCINP] [varchar](1) NOT NULL,
 CONSTRAINT [SA2010_PK] PRIMARY KEY CLUSTERED 
(
	[R_E_C_N_O_] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SA3010]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SA3010](
	[A3_FILIAL] [varchar](2) NOT NULL,
	[A3_COD] [varchar](6) NOT NULL,
	[A3_NOME] [varchar](40) NOT NULL,
	[A3_NREDUZ] [varchar](25) NOT NULL,
	[A3_END] [varchar](40) NOT NULL,
	[A3_BAIRRO] [varchar](20) NOT NULL,
	[A3_MUN] [varchar](15) NOT NULL,
	[A3_EST] [varchar](2) NOT NULL,
	[A3_CEP] [varchar](8) NOT NULL,
	[A3_DDDTEL] [varchar](3) NOT NULL,
	[A3_TEL] [varchar](15) NOT NULL,
	[A3_FAX] [varchar](15) NOT NULL,
	[A3_TELEX] [varchar](10) NOT NULL,
	[A3_TIPO] [varchar](1) NOT NULL,
	[A3_CGC] [varchar](14) NOT NULL,
	[A3_INSCR] [varchar](18) NOT NULL,
	[A3_INSCRM] [varchar](18) NOT NULL,
	[A3_EMAIL] [varchar](80) NOT NULL,
	[A3_HPAGE] [varchar](30) NOT NULL,
	[A3_CODUSR] [varchar](6) NOT NULL,
	[A3_SUPER] [varchar](6) NOT NULL,
	[A3_GEREN] [varchar](6) NOT NULL,
	[A3_FORNECE] [varchar](6) NOT NULL,
	[A3_LOJA] [varchar](2) NOT NULL,
	[A3_GERASE2] [varchar](1) NOT NULL,
	[A3_BCO1] [varchar](3) NOT NULL,
	[A3_REGIAO] [varchar](3) NOT NULL,
	[A3_COMIS] [float] NOT NULL,
	[A3_ALEMISS] [float] NOT NULL,
	[A3_ALBAIXA] [float] NOT NULL,
	[A3_ICM] [varchar](1) NOT NULL,
	[A3_ICMSRET] [varchar](1) NOT NULL,
	[A3_ISS] [varchar](1) NOT NULL,
	[A3_IPI] [varchar](1) NOT NULL,
	[A3_FRETE] [varchar](1) NOT NULL,
	[A3_ACREFIN] [varchar](1) NOT NULL,
	[A3_DIA] [float] NOT NULL,
	[A3_DDD] [varchar](1) NOT NULL,
	[A3_PERDESC] [float] NOT NULL,
	[A3_TIPSUP] [varchar](3) NOT NULL,
	[A3_DIARESE] [float] NOT NULL,
	[A3_SENHA] [varchar](6) NOT NULL,
	[A3_UNIDAD] [varchar](6) NOT NULL,
	[A3_HAND] [varchar](1) NOT NULL,
	[A3_PEDINI] [varchar](6) NOT NULL,
	[A3_QTCONTA] [float] NOT NULL,
	[A3_PEDFIM] [varchar](6) NOT NULL,
	[A3_CLIINI] [varchar](6) NOT NULL,
	[A3_REGSLA] [varchar](6) NOT NULL,
	[A3_CLIFIM] [varchar](6) NOT NULL,
	[A3_CARGO] [varchar](6) NOT NULL,
	[A3_PROXPED] [varchar](6) NOT NULL,
	[A3_PROXCLI] [varchar](6) NOT NULL,
	[A3_GRPREP] [varchar](6) NOT NULL,
	[A3_FAT_RH] [varchar](2) NOT NULL,
	[A3_GRUPSAN] [varchar](6) NOT NULL,
	[A3_DEPEND] [varchar](2) NOT NULL,
	[A3_PEN_ALI] [float] NOT NULL,
	[A3_TIPVEND] [varchar](1) NOT NULL,
	[A3_NUMRA] [varchar](6) NOT NULL,
	[A3_URLEXG] [varchar](50) NOT NULL,
	[A3_PAIS] [varchar](3) NOT NULL,
	[A3_DDI] [varchar](6) NOT NULL,
	[A3_CEL] [varchar](15) NOT NULL,
	[A3_ADMISS] [varchar](8) NOT NULL,
	[D_E_L_E_T_] [varchar](1) NOT NULL,
	[R_E_C_N_O_] [int] NOT NULL,
	[R_E_C_D_E_L_] [int] NOT NULL,
	[A3_X_CODMU] [varchar](5) NOT NULL,
	[A3_X_PESS] [varchar](1) NOT NULL,
	[A3_X_RG] [varchar](18) NOT NULL,
	[A3_X_FPGTO] [varchar](3) NOT NULL,
	[A3_X_TIPO] [varchar](1) NOT NULL,
	[A3_MSBLQL] [varchar](1) NOT NULL,
	[A3_X_SALDO] [float] NOT NULL,
	[A3_X_SUPER] [varchar](6) NOT NULL,
	[A3_X_PMAX] [float] NOT NULL,
	[A3_NVLSTR] [varchar](30) NOT NULL,
	[A3_NIVEL] [float] NOT NULL,
	[A3_LANEXG] [varchar](5) NOT NULL,
	[A3_X_WORK1] [varchar](1) NOT NULL,
	[A3_X_WORK2] [varchar](1) NOT NULL,
	[A3_SINCTAF] [varchar](1) NOT NULL,
	[A3_SINCAGE] [varchar](1) NOT NULL,
	[A3_SINCCON] [varchar](1) NOT NULL,
	[A3_PERAGE] [varchar](1) NOT NULL,
	[A3_PERTAF] [varchar](1) NOT NULL,
	[A3_TIMEMIN] [varchar](4) NOT NULL,
	[A3_USUCORP] [varchar](30) NOT NULL,
	[A3_HABSINC] [varchar](1) NOT NULL,
	[A3_PISCOF] [varchar](1) NOT NULL,
	[A3_BASEIR] [varchar](1) NOT NULL,
	[A3_CODISS] [varchar](6) NOT NULL,
 CONSTRAINT [SA3010_PK] PRIMARY KEY CLUSTERED 
(
	[R_E_C_N_O_] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SA4010]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SA4010](
	[A4_FILIAL] [varchar](2) NOT NULL,
	[A4_COD] [varchar](6) NOT NULL,
	[A4_NOME] [varchar](40) NOT NULL,
	[A4_NREDUZ] [varchar](15) NOT NULL,
	[A4_VIA] [varchar](15) NOT NULL,
	[A4_END] [varchar](40) NOT NULL,
	[A4_BAIRRO] [varchar](30) NOT NULL,
	[A4_MUN] [varchar](15) NOT NULL,
	[A4_EST] [varchar](2) NOT NULL,
	[A4_CEP] [varchar](8) NOT NULL,
	[A4_DDI] [varchar](6) NOT NULL,
	[A4_DDD] [varchar](3) NOT NULL,
	[A4_TEL] [varchar](15) NOT NULL,
	[A4_CGC] [varchar](14) NOT NULL,
	[A4_TELEX] [varchar](10) NOT NULL,
	[A4_INSEST] [varchar](15) NOT NULL,
	[A4_EMAIL] [varchar](60) NOT NULL,
	[A4_HPAGE] [varchar](30) NOT NULL,
	[A4_CONTATO] [varchar](15) NOT NULL,
	[A4_ESTFIS] [varchar](6) NOT NULL,
	[A4_ENDPAD] [varchar](15) NOT NULL,
	[A4_LOCAL] [varchar](2) NOT NULL,
	[A4_RATFRE] [varchar](1) NOT NULL,
	[A4_COMPLEM] [varchar](50) NOT NULL,
	[A4_COD_MUN] [varchar](9) NOT NULL,
	[A4_FOMEZER] [varchar](1) NOT NULL,
	[A4_SUFRAMA] [varchar](12) NOT NULL,
	[A4_CODPAIS] [varchar](5) NOT NULL,
	[A4_TPTRANS] [varchar](1) NOT NULL,
	[D_E_L_E_T_] [varchar](1) NOT NULL,
	[R_E_C_N_O_] [int] NOT NULL,
	[R_E_C_D_E_L_] [int] NOT NULL,
	[A4_ENDNOT] [varchar](1) NOT NULL,
	[A4_COLIG] [varchar](1) NOT NULL,
	[A4_IDETIQ] [varchar](10) NOT NULL,
	[A4_X_ATIV] [varchar](1) NOT NULL,
 CONSTRAINT [SA4010_PK] PRIMARY KEY CLUSTERED 
(
	[R_E_C_N_O_] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SB1010]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB1010](
	[B1_PARCEI] [varchar](6) NOT NULL,
	[B1_FILIAL] [varchar](2) NOT NULL,
	[B1_COD] [varchar](15) NOT NULL,
	[B1_TIPO] [varchar](2) NOT NULL,
	[B1_CODITE] [varchar](27) NOT NULL,
	[B1_UM] [varchar](2) NOT NULL,
	[B1_LOCPAD] [varchar](2) NOT NULL,
	[B1_GRUPO] [varchar](4) NOT NULL,
	[B1_PICM] [float] NOT NULL,
	[B1_IPI] [float] NOT NULL,
	[B1_POSIPI] [varchar](10) NOT NULL,
	[B1_EX_NCM] [varchar](3) NOT NULL,
	[B1_EX_NBM] [varchar](3) NOT NULL,
	[B1_ALIQISS] [float] NOT NULL,
	[B1_CODISS] [varchar](9) NOT NULL,
	[B1_MSBLQL] [varchar](1) NOT NULL,
	[B1_TE] [varchar](3) NOT NULL,
	[B1_TS] [varchar](3) NOT NULL,
	[B1_PICMRET] [float] NOT NULL,
	[B1_PICMENT] [float] NOT NULL,
	[B1_IMPZFRC] [varchar](1) NOT NULL,
	[B1_BITMAP] [varchar](20) NOT NULL,
	[B1_SEGUM] [varchar](2) NOT NULL,
	[B1_CONV] [float] NOT NULL,
	[B1_TIPCONV] [varchar](1) NOT NULL,
	[B1_ALTER] [varchar](15) NOT NULL,
	[B1_QE] [float] NOT NULL,
	[B1_PRV1] [float] NOT NULL,
	[B1_EMIN] [float] NOT NULL,
	[B1_CUSTD] [float] NOT NULL,
	[B1_UCALSTD] [varchar](8) NOT NULL,
	[B1_UPRC] [float] NOT NULL,
	[B1_MCUSTD] [varchar](1) NOT NULL,
	[B1_UCOM] [varchar](8) NOT NULL,
	[B1_PESO] [float] NOT NULL,
	[B1_ESTSEG] [float] NOT NULL,
	[B1_ESTFOR] [varchar](3) NOT NULL,
	[B1_FORPRZ] [varchar](3) NOT NULL,
	[B1_PE] [float] NOT NULL,
	[B1_TIPE] [varchar](1) NOT NULL,
	[B1_LE] [float] NOT NULL,
	[B1_LM] [float] NOT NULL,
	[B1_CONTA] [varchar](20) NOT NULL,
	[B1_TOLER] [float] NOT NULL,
	[B1_CC] [varchar](9) NOT NULL,
	[B1_ITEMCC] [varchar](11) NOT NULL,
	[B1_FAMILIA] [varchar](1) NOT NULL,
	[B1_PROC] [varchar](6) NOT NULL,
	[B1_QB] [float] NOT NULL,
	[B1_LOJPROC] [varchar](2) NOT NULL,
	[B1_APROPRI] [varchar](1) NOT NULL,
	[B1_TIPODEC] [varchar](1) NOT NULL,
	[B1_ORIGEM] [varchar](1) NOT NULL,
	[B1_CLASFIS] [varchar](2) NOT NULL,
	[B1_FANTASM] [varchar](1) NOT NULL,
	[B1_RASTRO] [varchar](1) NOT NULL,
	[B1_UREV] [varchar](8) NOT NULL,
	[B1_DATREF] [varchar](8) NOT NULL,
	[B1_FORAEST] [varchar](1) NOT NULL,
	[B1_COMIS] [float] NOT NULL,
	[B1_MONO] [varchar](1) NOT NULL,
	[B1_PERINV] [float] NOT NULL,
	[B1_DTREFP1] [varchar](8) NOT NULL,
	[B1_GRTRIB] [varchar](6) NOT NULL,
	[B1_MRP] [varchar](1) NOT NULL,
	[B1_NOTAMIN] [float] NOT NULL,
	[B1_PRVALID] [float] NOT NULL,
	[B1_NUMCOP] [float] NOT NULL,
	[B1_CONINI] [varchar](8) NOT NULL,
	[B1_CONTSOC] [varchar](1) NOT NULL,
	[B1_IRRF] [varchar](1) NOT NULL,
	[B1_CODBAR] [varchar](15) NOT NULL,
	[B1_GRADE] [varchar](1) NOT NULL,
	[B1_FORMLOT] [varchar](3) NOT NULL,
	[B1_LOCALIZ] [varchar](1) NOT NULL,
	[B1_FPCOD] [varchar](2) NOT NULL,
	[B1_OPERPAD] [varchar](2) NOT NULL,
	[B1_CONTRAT] [varchar](1) NOT NULL,
	[B1_DESC_P] [varchar](6) NOT NULL,
	[B1_DESC_GI] [varchar](6) NOT NULL,
	[B1_DESC_I] [varchar](6) NOT NULL,
	[B1_VLREFUS] [float] NOT NULL,
	[B1_IMPORT] [varchar](1) NOT NULL,
	[B1_OPC] [varchar](80) NOT NULL,
	[B1_ANUENTE] [varchar](1) NOT NULL,
	[B1_CODOBS] [varchar](6) NOT NULL,
	[B1_SITPROD] [varchar](2) NOT NULL,
	[B1_FABRIC] [varchar](20) NOT NULL,
	[B1_MODELO] [varchar](30) NOT NULL,
	[B1_SETOR] [varchar](2) NOT NULL,
	[B1_BALANCA] [varchar](1) NOT NULL,
	[B1_TECLA] [varchar](3) NOT NULL,
	[B1_PRODPAI] [varchar](15) NOT NULL,
	[B1_TIPOCQ] [varchar](1) NOT NULL,
	[B1_SOLICIT] [varchar](1) NOT NULL,
	[B1_QUADPRO] [varchar](1) NOT NULL,
	[B1_AGREGCU] [varchar](1) NOT NULL,
	[B1_GRUPCOM] [varchar](6) NOT NULL,
	[B1_DESPIMP] [varchar](1) NOT NULL,
	[B1_NUMCQPR] [float] NOT NULL,
	[B1_CONTCQP] [float] NOT NULL,
	[B1_REVATU] [varchar](3) NOT NULL,
	[B1_INSS] [varchar](1) NOT NULL,
	[B1_CODEMB] [varchar](20) NOT NULL,
	[B1_ESPECIF] [varchar](80) NOT NULL,
	[B1_MAT_PRI] [varchar](20) NOT NULL,
	[B1_REDINSS] [float] NOT NULL,
	[B1_NALNCCA] [varchar](7) NOT NULL,
	[B1_REDIRRF] [float] NOT NULL,
	[B1_ALADI] [varchar](3) NOT NULL,
	[B1_NALSH] [varchar](8) NOT NULL,
	[B1_TAB_IPI] [varchar](2) NOT NULL,
	[B1_GRUDES] [varchar](3) NOT NULL,
	[B1_REDPIS] [float] NOT NULL,
	[B1_REDCOF] [float] NOT NULL,
	[B1_DATASUB] [varchar](8) NOT NULL,
	[B1_PCSLL] [float] NOT NULL,
	[B1_PCOFINS] [float] NOT NULL,
	[B1_PPIS] [float] NOT NULL,
	[B1_MTBF] [float] NOT NULL,
	[B1_MTTR] [float] NOT NULL,
	[B1_FLAGSUG] [varchar](1) NOT NULL,
	[B1_CLASSVE] [varchar](1) NOT NULL,
	[B1_MIDIA] [varchar](1) NOT NULL,
	[B1_QTMIDIA] [float] NOT NULL,
	[B1_VLR_IPI] [float] NOT NULL,
	[B1_ENVOBR] [varchar](1) NOT NULL,
	[B1_QTDSER] [float] NOT NULL,
	[B1_SERIE] [varchar](20) NOT NULL,
	[B1_FAIXAS] [float] NOT NULL,
	[B1_NROPAG] [float] NOT NULL,
	[B1_ISBN] [varchar](10) NOT NULL,
	[B1_TITORIG] [varchar](50) NOT NULL,
	[B1_LINGUA] [varchar](20) NOT NULL,
	[B1_EDICAO] [varchar](3) NOT NULL,
	[B1_OBSISBN] [varchar](40) NOT NULL,
	[B1_CLVL] [varchar](20) NOT NULL,
	[B1_ATIVO] [varchar](1) NOT NULL,
	[B1_EMAX] [float] NOT NULL,
	[B1_PESBRU] [float] NOT NULL,
	[B1_TIPCAR] [varchar](6) NOT NULL,
	[B1_FRACPER] [float] NOT NULL,
	[B1_INT_ICM] [float] NOT NULL,
	[B1_VLR_ICM] [float] NOT NULL,
	[B1_VLRSELO] [float] NOT NULL,
	[B1_CODNOR] [varchar](3) NOT NULL,
	[B1_CORPRI] [varchar](6) NOT NULL,
	[B1_CORSEC] [varchar](6) NOT NULL,
	[B1_NICONE] [varchar](15) NOT NULL,
	[B1_ATRIB1] [varchar](6) NOT NULL,
	[B1_ATRIB2] [varchar](6) NOT NULL,
	[B1_ATRIB3] [varchar](6) NOT NULL,
	[B1_REGSEQ] [varchar](6) NOT NULL,
	[B1_CPOTENC] [varchar](1) NOT NULL,
	[B1_POTENCI] [float] NOT NULL,
	[B1_QTDACUM] [float] NOT NULL,
	[B1_QTDINIC] [float] NOT NULL,
	[B1_REQUIS] [varchar](1) NOT NULL,
	[B1_SELO] [varchar](1) NOT NULL,
	[B1_LOTVEN] [float] NOT NULL,
	[B1_OK] [varchar](4) NOT NULL,
	[B1_USAFEFO] [varchar](1) NOT NULL,
	[B1_GCCUSTO] [varchar](8) NOT NULL,
	[B1_CCCUSTO] [varchar](9) NOT NULL,
	[B1_CLASSE] [varchar](6) NOT NULL,
	[B1_PMACNUT] [float] NOT NULL,
	[B1_PMICNUT] [float] NOT NULL,
	[B1_CODQAD] [varchar](13) NOT NULL,
	[B1_QBP] [float] NOT NULL,
	[B1_PIS] [varchar](1) NOT NULL,
	[B1_VLR_PIS] [float] NOT NULL,
	[B1_UMOEC] [float] NOT NULL,
	[B1_UVLRC] [float] NOT NULL,
	[B1_RETOPER] [varchar](1) NOT NULL,
	[B1_CNAE] [varchar](9) NOT NULL,
	[B1_CRDEST] [float] NOT NULL,
	[B1_COFINS] [varchar](1) NOT NULL,
	[B1_CSLL] [varchar](1) NOT NULL,
	[B1_PRFDSUL] [float] NOT NULL,
	[B1_CODANT] [varchar](15) NOT NULL,
	[B1_FETHAB] [varchar](1) NOT NULL,
	[B1_FRETISS] [varchar](1) NOT NULL,
	[B1_CALCFET] [varchar](1) NOT NULL,
	[B1_PAUTFET] [float] NOT NULL,
	[B1_VLR_COF] [float] NOT NULL,
	[D_E_L_E_T_] [varchar](1) NOT NULL,
	[R_E_C_N_O_] [int] NOT NULL,
	[R_E_C_D_E_L_] [int] NOT NULL,
	[B1_PRODSBP] [varchar](1) NOT NULL,
	[B1_ESTRORI] [varchar](15) NOT NULL,
	[B1_LOTESBP] [float] NOT NULL,
	[B1_TPREG] [varchar](1) NOT NULL,
	[B1_IVAAJU] [varchar](1) NOT NULL,
	[B1_FUSTF] [varchar](1) NOT NULL,
	[B1_REGRISS] [varchar](2) NOT NULL,
	[B1_ESCRIPI] [varchar](1) NOT NULL,
	[B1_FECP] [float] NOT NULL,
	[B1_X_MARKU] [float] NOT NULL,
	[B1_X_REFER] [varchar](10) NOT NULL,
	[B1_X_ANVIS] [varchar](15) NOT NULL,
	[B1_DESC] [varchar](50) NOT NULL,
	[B1_X_PROMO] [varchar](1) NOT NULL,
	[B1_X_ULICM] [float] NOT NULL,
	[B1_X_ULIPI] [float] NOT NULL,
	[B1_X_ULIST] [float] NOT NULL,
	[B1_X_CUSFI] [float] NOT NULL,
	[B1_X_ULDOC] [varchar](9) NOT NULL,
	[B1_X_ULSER] [varchar](3) NOT NULL,
	[B1_X_ULDAT] [varchar](8) NOT NULL,
	[B1_X_ULFOR] [varchar](6) NOT NULL,
	[B1_X_ULLOJ] [varchar](2) NOT NULL,
	[B1_X_UPRC1] [float] NOT NULL,
	[B1_X_UPRC2] [float] NOT NULL,
	[B1_X_SET] [varchar](4) NOT NULL,
	[B1_X_FLAG] [varchar](1) NOT NULL,
	[B1_X_DTINC] [varchar](8) NOT NULL,
	[B1_X_HRINC] [varchar](8) NOT NULL,
	[B1_X_USINC] [varchar](20) NOT NULL,
	[B1_X_RUA] [varchar](2) NOT NULL,
	[B1_X_IMETQ] [varchar](1) NOT NULL,
	[B1_X_PISCO] [varchar](1) NOT NULL,
	[B1_X_CODL] [varchar](1) NOT NULL,
	[B1_X_TSINT] [varchar](3) NOT NULL,
	[B1_X_DTPRC] [varchar](8) NOT NULL,
	[B1_X_HRPRC] [varchar](8) NOT NULL,
	[B1_X_USPRC] [varchar](20) NOT NULL,
	[B1_X_STPRC] [varchar](1) NOT NULL,
	[B1_X_RTPRC] [varchar](10) NOT NULL,
	[B1_X_TET] [varchar](3) NOT NULL,
	[B1__AVULSO] [varchar](1) NOT NULL,
	[B1__PRDSUP] [varchar](15) NOT NULL,
	[B1__MULAVU] [float] NOT NULL,
	[B1__GRTRIB] [varchar](6) NOT NULL,
	[B1__BLQREC] [varchar](1) NOT NULL,
	[B1_X_SIMI] [float] NOT NULL,
	[B1_X_FABRI] [varchar](6) NOT NULL,
	[B1_X_ESTM] [float] NOT NULL,
	[B1_RPRODEP] [varchar](1) NOT NULL,
	[B1_SELOEN] [varchar](6) NOT NULL,
	[B1_ALFECOP] [float] NOT NULL,
	[B1_ALFECST] [float] NOT NULL,
	[B1_FECOP] [varchar](1) NOT NULL,
	[B1_CRICMS] [varchar](1) NOT NULL,
	[B1_PRODREC] [varchar](1) NOT NULL,
	[B1_TRIBMUN] [varchar](20) NOT NULL,
	[B1_VIGENC] [varchar](8) NOT NULL,
	[B1_CRDPRES] [float] NOT NULL,
	[B1_AFETHAB] [float] NOT NULL,
	[B1_AFACS] [float] NOT NULL,
	[B1_AFABOV] [float] NOT NULL,
	[B1_TFETHAB] [varchar](1) NOT NULL,
	[B1_REFBAS] [varchar](1) NOT NULL,
	[B1_TPPROD] [varchar](1) NOT NULL,
	[B1_VEREAN] [varchar](2) NOT NULL,
	[B1_PRDORI] [varchar](15) NOT NULL,
	[B1_RICM65] [varchar](1) NOT NULL,
	[B1_CFEM] [varchar](1) NOT NULL,
	[B1_CFEMS] [varchar](1) NOT NULL,
	[B1_CFEMA] [float] NOT NULL,
	[B1_X_FLGAV] [varchar](1) NOT NULL,
	[B1_X_CONTA] [varchar](20) NOT NULL,
	[B1_X_GRPA] [varchar](4) NOT NULL,
	[B1_X_SUBGR] [varchar](4) NOT NULL,
	[B1_TNATREC] [varchar](4) NOT NULL,
	[B1_CNATREC] [varchar](3) NOT NULL,
	[B1_ALFUMAC] [float] NOT NULL,
	[B1_DTCORTE] [varchar](8) NOT NULL,
	[B1_PRN944I] [varchar](1) NOT NULL,
	[B1_PR43080] [float] NOT NULL,
	[B1_CHASSI] [varchar](17) NOT NULL,
	[B1_CODLAN] [varchar](6) NOT NULL,
	[B1_X_CODF] [varchar](20) NOT NULL,
	[B1_X_DESCF] [varchar](50) NOT NULL,
	[B1_X_DESCO] [varchar](1) NOT NULL,
	[B1_X_COMIS] [float] NOT NULL,
	[B1_GRPNATR] [varchar](2) NOT NULL,
	[B1_DTFIMNT] [varchar](8) NOT NULL,
	[B1_FECPBA] [float] NOT NULL,
	[B1_DIFCNAE] [varchar](11) NOT NULL,
	[B1_DCI] [varchar](1) NOT NULL,
	[B1_DCRE] [varchar](10) NOT NULL,
	[B1_DCR] [varchar](9) NOT NULL,
	[B1_DCRII] [float] NOT NULL,
	[B1_COEFDCR] [float] NOT NULL,
	[B1_PRINCMG] [float] NOT NULL,
	[B1_X_OCUSF] [float] NOT NULL,
	[B1_X_WEB] [varchar](36) NOT NULL,
	[B1_REGESIM] [varchar](1) NOT NULL,
	[B1_RSATIVO] [varchar](1) NOT NULL,
	[B1_CRICMST] [varchar](1) NOT NULL,
	[B1_ALFECRN] [float] NOT NULL,
	[B1_X_PREDI] [varchar](3) NOT NULL,
	[B1_X_PRATE] [varchar](10) NOT NULL,
	[B1_X_ANDAR] [varchar](10) NOT NULL,
	[B1_X_TEDT] [varchar](3) NOT NULL,
	[B1_X_ECOMM] [varchar](1) NOT NULL,
	[B1_MEPLES] [varchar](1) NOT NULL,
	[B1_AJUDIF] [varchar](1) NOT NULL,
	[B1_DESBSE3] [varchar](60) NOT NULL,
	[B1_BASE3] [varchar](14) NOT NULL,
	[B1_IAT] [varchar](1) NOT NULL,
	[B1_IPPT] [varchar](1) NOT NULL,
	[B1_SITTRIB] [varchar](1) NOT NULL,
	[B1_TALLA] [varchar](6) NOT NULL,
	[B1_CODPROC] [varchar](6) NOT NULL,
	[B1_GDODIF] [varchar](1) NOT NULL,
	[B1_VLCIF] [float] NOT NULL,
	[B1_MARKUP] [float] NOT NULL,
	[B1_VALEPRE] [varchar](1) NOT NULL,
	[B1_TIPOBN] [varchar](2) NOT NULL,
	[B1_DESBSE2] [varchar](60) NOT NULL,
	[B1_CARGAE] [varchar](1) NOT NULL,
	[B1_ADMIN] [varchar](10) NOT NULL,
	[B1_BASE2] [varchar](14) NOT NULL,
	[B1_GARANT] [varchar](1) NOT NULL,
	[B1_TIPVEC] [varchar](6) NOT NULL,
	[B1_BASE] [varchar](14) NOT NULL,
	[B1_PERGART] [float] NOT NULL,
	[B1_COLOR] [varchar](10) NOT NULL,
	[B1_ESPECIE] [varchar](2) NOT NULL,
	[B1_TPDP] [varchar](1) NOT NULL,
	[B1_X_MNT] [varchar](10) NOT NULL,
	[B1_X_FRETA] [float] NOT NULL,
	[B1_X_FRETV] [float] NOT NULL,
	[B1_X_COMA] [float] NOT NULL,
	[B1_X_COMV] [float] NOT NULL,
	[B1_X_MRKPA] [float] NOT NULL,
	[B1_X_MRKPV] [float] NOT NULL,
	[B1_X_MRKMA] [float] NOT NULL,
	[B1_X_MRKMV] [float] NOT NULL,
	[B1_X_PSUG] [float] NOT NULL,
	[B1_PORCPRL] [varchar](2) NOT NULL,
	[B1_AFAMAD] [float] NOT NULL,
	[B1_IDHIST] [varchar](20) NOT NULL,
	[B1_MSEXP] [varchar](8) NOT NULL,
	[B1_PAFMD5] [varchar](32) NOT NULL,
	[B1_X_MRKDA] [float] NOT NULL,
	[B1_X_MRKDV] [float] NOT NULL,
	[B1_X_ULCUS] [float] NOT NULL,
	[B1_GRPTI] [varchar](4) NOT NULL,
	[B1_GRPCST] [varchar](3) NOT NULL,
	[B1_CEST] [varchar](9) NOT NULL,
	[B1_AFUNDES] [float] NOT NULL,
	[B1_AIMAMT] [float] NOT NULL,
	[B1_AFASEMT] [float] NOT NULL,
 CONSTRAINT [SB1010_PK] PRIMARY KEY CLUSTERED 
(
	[R_E_C_N_O_] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SB2010]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB2010](
	[B2_FILIAL] [varchar](2) NOT NULL,
	[B2_COD] [varchar](15) NOT NULL,
	[B2_QFIM] [float] NOT NULL,
	[B2_LOCAL] [varchar](2) NOT NULL,
	[B2_QATU] [float] NOT NULL,
	[B2_VFIM1] [float] NOT NULL,
	[B2_VATU1] [float] NOT NULL,
	[B2_CM1] [float] NOT NULL,
	[B2_VFIM2] [float] NOT NULL,
	[B2_VATU2] [float] NOT NULL,
	[B2_CM2] [float] NOT NULL,
	[B2_VFIM3] [float] NOT NULL,
	[B2_VATU3] [float] NOT NULL,
	[B2_CM3] [float] NOT NULL,
	[B2_VFIM4] [float] NOT NULL,
	[B2_VATU4] [float] NOT NULL,
	[B2_CM4] [float] NOT NULL,
	[B2_VFIM5] [float] NOT NULL,
	[B2_VATU5] [float] NOT NULL,
	[B2_CM5] [float] NOT NULL,
	[B2_QEMP] [float] NOT NULL,
	[B2_QEMPN] [float] NOT NULL,
	[B2_QTSEGUM] [float] NOT NULL,
	[B2_USAI] [varchar](8) NOT NULL,
	[B2_RESERVA] [float] NOT NULL,
	[B2_QPEDVEN] [float] NOT NULL,
	[B2_LOCALIZ] [varchar](15) NOT NULL,
	[B2_NAOCLAS] [float] NOT NULL,
	[B2_SALPEDI] [float] NOT NULL,
	[B2_DINVENT] [varchar](8) NOT NULL,
	[B2_DINVFIM] [varchar](8) NOT NULL,
	[B2_QTNP] [float] NOT NULL,
	[B2_QNPT] [float] NOT NULL,
	[B2_QTER] [float] NOT NULL,
	[B2_QFIM2] [float] NOT NULL,
	[B2_QACLASS] [float] NOT NULL,
	[B2_DTINV] [varchar](8) NOT NULL,
	[B2_CMFF1] [float] NOT NULL,
	[B2_CMFF2] [float] NOT NULL,
	[B2_CMFF3] [float] NOT NULL,
	[B2_CMFF4] [float] NOT NULL,
	[B2_CMFF5] [float] NOT NULL,
	[B2_VFIMFF1] [float] NOT NULL,
	[B2_VFIMFF2] [float] NOT NULL,
	[B2_VFIMFF3] [float] NOT NULL,
	[B2_VFIMFF4] [float] NOT NULL,
	[B2_VFIMFF5] [float] NOT NULL,
	[B2_QEMPSA] [float] NOT NULL,
	[B2_QEMPPRE] [float] NOT NULL,
	[B2_SALPPRE] [float] NOT NULL,
	[B2_QEMP2] [float] NOT NULL,
	[B2_QEMPN2] [float] NOT NULL,
	[B2_RESERV2] [float] NOT NULL,
	[B2_QPEDVE2] [float] NOT NULL,
	[B2_QEPRE2] [float] NOT NULL,
	[B2_QFIMFF] [float] NOT NULL,
	[B2_SALPED2] [float] NOT NULL,
	[B2_QEMPPRJ] [float] NOT NULL,
	[B2_QEMPPR2] [float] NOT NULL,
	[B2_STATUS] [varchar](1) NOT NULL,
	[B2_CMFIM1] [float] NOT NULL,
	[B2_CMFIM2] [float] NOT NULL,
	[B2_CMFIM3] [float] NOT NULL,
	[B2_CMFIM4] [float] NOT NULL,
	[B2_CMFIM5] [float] NOT NULL,
	[B2_TIPO] [varchar](1) NOT NULL,
	[D_E_L_E_T_] [varchar](1) NOT NULL,
	[R_E_C_N_O_] [int] NOT NULL,
	[R_E_C_D_E_L_] [int] NOT NULL,
	[B2_BLOQUEI] [varchar](1) NOT NULL,
	[B2_CMRP1] [float] NOT NULL,
	[B2_VFRP1] [float] NOT NULL,
	[B2_CMRP2] [float] NOT NULL,
	[B2_VFRP2] [float] NOT NULL,
	[B2_CMRP3] [float] NOT NULL,
	[B2_VFRP3] [float] NOT NULL,
	[B2_CMRP4] [float] NOT NULL,
	[B2_VFRP4] [float] NOT NULL,
	[B2_CMRP5] [float] NOT NULL,
	[B2_VFRP5] [float] NOT NULL,
	[B2_QULT] [float] NOT NULL,
	[B2_DULT] [varchar](8) NOT NULL,
	[B2_MSEXP] [varchar](8) NOT NULL,
 CONSTRAINT [SB2010_PK] PRIMARY KEY CLUSTERED 
(
	[R_E_C_N_O_] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SBM010]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SBM010](
	[BM_FILIAL] [varchar](2) NOT NULL,
	[BM_GRUPO] [varchar](4) NOT NULL,
	[BM_DESC] [varchar](30) NOT NULL,
	[BM_PICPAD] [varchar](30) NOT NULL,
	[BM_PROORI] [varchar](1) NOT NULL,
	[BM_CODMAR] [varchar](3) NOT NULL,
	[BM_STATUS] [varchar](1) NOT NULL,
	[BM_GRUREL] [varchar](40) NOT NULL,
	[BM_TIPGRU] [varchar](2) NOT NULL,
	[BM_MARKUP] [float] NOT NULL,
	[BM_PRECO] [varchar](3) NOT NULL,
	[BM_LENREL] [float] NOT NULL,
	[BM_TIPMOV] [varchar](1) NOT NULL,
	[D_E_L_E_T_] [varchar](1) NOT NULL,
	[R_E_C_N_O_] [int] NOT NULL,
	[R_E_C_D_E_L_] [int] NOT NULL,
	[BM_X_CONTA] [varchar](20) NOT NULL,
	[BM__BLQREC] [varchar](1) NOT NULL,
	[BM_CLASGRU] [varchar](1) NOT NULL,
	[BM_FORMUL] [varchar](6) NOT NULL,
 CONSTRAINT [SBM010_PK] PRIMARY KEY CLUSTERED 
(
	[R_E_C_N_O_] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SC5010]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SC5010](
	[C5_FILIAL] [varchar](2) NOT NULL,
	[C5_NUM] [varchar](6) NOT NULL,
	[C5_TIPO] [varchar](1) NOT NULL,
	[C5_CLIENTE] [varchar](6) NOT NULL,
	[C5_LOJACLI] [varchar](2) NOT NULL,
	[C5_CLIENT] [varchar](6) NOT NULL,
	[C5_LOJAENT] [varchar](2) NOT NULL,
	[C5_TRANSP] [varchar](6) NOT NULL,
	[C5_TIPOCLI] [varchar](1) NOT NULL,
	[C5_CONDPAG] [varchar](3) NOT NULL,
	[C5_TABELA] [varchar](3) NOT NULL,
	[C5_VEND1] [varchar](6) NOT NULL,
	[C5_COMIS1] [float] NOT NULL,
	[C5_VEND2] [varchar](6) NOT NULL,
	[C5_COMIS2] [float] NOT NULL,
	[C5_VEND3] [varchar](6) NOT NULL,
	[C5_COMIS3] [float] NOT NULL,
	[C5_VEND4] [varchar](6) NOT NULL,
	[C5_COMIS4] [float] NOT NULL,
	[C5_VEND5] [varchar](6) NOT NULL,
	[C5_COMIS5] [float] NOT NULL,
	[C5_DESC1] [float] NOT NULL,
	[C5_DESC2] [float] NOT NULL,
	[C5_DESC3] [float] NOT NULL,
	[C5_DESC4] [float] NOT NULL,
	[C5_BANCO] [varchar](3) NOT NULL,
	[C5_DESCFI] [float] NOT NULL,
	[C5_EMISSAO] [varchar](8) NOT NULL,
	[C5_COTACAO] [varchar](6) NOT NULL,
	[C5_PARC1] [float] NOT NULL,
	[C5_DATA1] [varchar](8) NOT NULL,
	[C5_PARC2] [float] NOT NULL,
	[C5_DATA2] [varchar](8) NOT NULL,
	[C5_PARC3] [float] NOT NULL,
	[C5_DATA3] [varchar](8) NOT NULL,
	[C5_PARC4] [float] NOT NULL,
	[C5_DATA4] [varchar](8) NOT NULL,
	[C5_TPFRETE] [varchar](1) NOT NULL,
	[C5_FRETE] [float] NOT NULL,
	[C5_SEGURO] [float] NOT NULL,
	[C5_DESPESA] [float] NOT NULL,
	[C5_FRETAUT] [float] NOT NULL,
	[C5_REAJUST] [varchar](3) NOT NULL,
	[C5_MOEDA] [float] NOT NULL,
	[C5_PESOL] [float] NOT NULL,
	[C5_PBRUTO] [float] NOT NULL,
	[C5_REIMP] [float] NOT NULL,
	[C5_REDESP] [varchar](6) NOT NULL,
	[C5_VOLUME1] [float] NOT NULL,
	[C5_VOLUME2] [float] NOT NULL,
	[C5_VOLUME3] [float] NOT NULL,
	[C5_VOLUME4] [float] NOT NULL,
	[C5_ESPECI1] [varchar](10) NOT NULL,
	[C5_ESPECI2] [varchar](10) NOT NULL,
	[C5_ESPECI3] [varchar](10) NOT NULL,
	[C5_ESPECI4] [varchar](10) NOT NULL,
	[C5_ACRSFIN] [float] NOT NULL,
	[C5_MENNOTA] [varchar](60) NOT NULL,
	[C5_MENPAD] [varchar](3) NOT NULL,
	[C5_INCISS] [varchar](1) NOT NULL,
	[C5_LIBEROK] [varchar](1) NOT NULL,
	[C5_OK] [varchar](2) NOT NULL,
	[C5_NOTA] [varchar](9) NOT NULL,
	[C5_SERIE] [varchar](3) NOT NULL,
	[C5_KITREP] [varchar](6) NOT NULL,
	[C5_OS] [varchar](6) NOT NULL,
	[C5_TIPLIB] [varchar](1) NOT NULL,
	[C5_DESCONT] [float] NOT NULL,
	[C5_PEDEXP] [varchar](20) NOT NULL,
	[C5_TXMOEDA] [float] NOT NULL,
	[C5_TPCARGA] [varchar](1) NOT NULL,
	[C5_PDESCAB] [float] NOT NULL,
	[C5_BLQ] [varchar](1) NOT NULL,
	[C5_FORNISS] [varchar](6) NOT NULL,
	[C5_CONTRA] [varchar](10) NOT NULL,
	[C5_VLR_FRT] [float] NOT NULL,
	[C5_MDCONTR] [varchar](15) NOT NULL,
	[C5_GERAWMS] [varchar](1) NOT NULL,
	[C5_MDNUMED] [varchar](6) NOT NULL,
	[C5_MDPLANI] [varchar](6) NOT NULL,
	[C5_SOLFRE] [varchar](2) NOT NULL,
	[C5_ORCRES] [varchar](6) NOT NULL,
	[C5_RECFAUT] [varchar](1) NOT NULL,
	[C5_RECISS] [varchar](1) NOT NULL,
	[D_E_L_E_T_] [varchar](1) NOT NULL,
	[R_E_C_N_O_] [int] NOT NULL,
	[R_E_C_D_E_L_] [int] NOT NULL,
	[C5_X_OBS] [image] NULL,
	[C5_X_DTINC] [varchar](8) NOT NULL,
	[C5_X_CDUSR] [varchar](6) NOT NULL,
	[C5_X_NOUSR] [varchar](30) NOT NULL,
	[C5_X_HRINC] [varchar](8) NOT NULL,
	[C5_X_NOCLI] [varchar](40) NOT NULL,
	[C5_PARC5] [float] NOT NULL,
	[C5_PARC6] [float] NOT NULL,
	[C5_DATA5] [varchar](8) NOT NULL,
	[C5_DATA6] [varchar](8) NOT NULL,
	[C5_X_NPARC] [varchar](2) NOT NULL,
	[C5_PARC7] [float] NOT NULL,
	[C5_DATA7] [varchar](8) NOT NULL,
	[C5_X_COND9] [varchar](3) NOT NULL,
	[C5_X_FLGCO] [varchar](1) NOT NULL,
	[C5_X_TXTCO] [varchar](20) NOT NULL,
	[C5_X_ORIG] [varchar](1) NOT NULL,
	[C5_X_PEDCL] [varchar](9) NOT NULL,
	[C5_X_CODFR] [varchar](7) NOT NULL,
	[C5_X_STATU] [varchar](3) NOT NULL,
	[C5_X_ATEND] [float] NOT NULL,
	[C5_X_FORMA] [varchar](3) NOT NULL,
	[C5_X_SERIE] [varchar](3) NOT NULL,
	[C5_X_NOTA] [varchar](12) NOT NULL,
	[C5_X_ID] [varchar](14) NOT NULL,
	[C5_X_PLACA] [varchar](7) NOT NULL,
	[C5_X_SITUA] [varchar](3) NOT NULL,
	[C5_X_FILOR] [varchar](2) NOT NULL,
	[C5_X_PEDOR] [varchar](6) NOT NULL,
	[C5_X_FILDE] [varchar](2) NOT NULL,
	[C5_X_PEDDE] [varchar](6) NOT NULL,
	[C5_X_PARC1] [float] NOT NULL,
	[C5_X_PARC2] [float] NOT NULL,
	[C5_X_PARC3] [float] NOT NULL,
	[C5_X_PARC4] [float] NOT NULL,
	[C5_X_PARC5] [float] NOT NULL,
	[C5_X_PARC6] [float] NOT NULL,
	[C5_X_PARC7] [float] NOT NULL,
	[C5_X_OBPEN] [varchar](80) NOT NULL,
	[C5__SERIE] [varchar](1) NOT NULL,
	[C5_X_TPPED] [varchar](1) NOT NULL,
	[C5_X_OPER] [varchar](2) NOT NULL,
	[C5_X_TRANS] [varchar](6) NOT NULL,
	[C5_X_USIMP] [varchar](20) NOT NULL,
	[C5_X_DTIMP] [varchar](8) NOT NULL,
	[C5_X_HRIMP] [varchar](8) NOT NULL,
	[C5_X_NRIMP] [float] NOT NULL,
	[C5_X_ADMFI] [varchar](3) NOT NULL,
	[C5_X_COMIS] [float] NOT NULL,
	[C5_X_UNIMP] [varchar](1) NOT NULL,
	[C5_X_VEND2] [varchar](6) NOT NULL,
	[C5_X_VEND3] [varchar](6) NOT NULL,
	[C5_X_PEDSE] [varchar](1) NOT NULL,
	[C5_X_DTATU] [varchar](8) NOT NULL,
	[C5_X_HRATU] [varchar](8) NOT NULL,
	[C5_X_USATU] [varchar](20) NOT NULL,
	[C5_X_OBPED] [image] NULL,
	[C5_X_ARQPO] [varchar](40) NOT NULL,
	[C5_X_USFTP] [varchar](20) NOT NULL,
	[C5_X_DTFTP] [varchar](8) NOT NULL,
	[C5_X_HRFTP] [varchar](8) NOT NULL,
	[C5_X_PAUSA] [varchar](1) NOT NULL,
	[C5_X_NPOCK] [varchar](10) NOT NULL,
	[C5_X_TPOPE] [varchar](6) NOT NULL,
	[C5_X_CATEG] [varchar](1) NOT NULL,
	[C5_X_DTENT] [varchar](8) NOT NULL,
	[C5_X_DTIM] [varchar](8) NOT NULL,
	[C5_X_OBSPK] [varchar](128) NOT NULL,
	[C5_X_TAB] [varchar](6) NOT NULL,
	[C5_X_PCFIL] [varchar](2) NOT NULL,
	[C5_X_PCNUM] [varchar](6) NOT NULL,
	[C5_X_PEDPR] [varchar](6) NOT NULL,
	[C5_PARC8] [float] NOT NULL,
	[C5_DATA8] [varchar](8) NOT NULL,
	[C5_PARC9] [float] NOT NULL,
	[C5_DATA9] [varchar](8) NOT NULL,
	[C5_X_PARC8] [float] NOT NULL,
	[C5_X_PARC9] [float] NOT NULL,
	[C5_PARCA] [float] NOT NULL,
	[C5_DATAA] [varchar](8) NOT NULL,
	[C5_X_PARCA] [float] NOT NULL,
	[C5_X_DTAB] [float] NOT NULL,
	[C5_X_DELIV] [varchar](1) NOT NULL,
	[C5_MUNPRES] [varchar](7) NOT NULL,
	[C5_DESCMUN] [varchar](30) NOT NULL,
	[C5_X_NCART] [varchar](19) NOT NULL,
	[C5_X_UFEMB] [varchar](2) NOT NULL,
	[C5_X_LOEMB] [varchar](20) NOT NULL,
	[C5_X_IMPBO] [varchar](1) NOT NULL,
	[C5_VEICULO] [varchar](8) NOT NULL,
	[C5_NFSUBST] [varchar](9) NOT NULL,
	[C5_SERSUBS] [varchar](3) NOT NULL,
	[C5_X_SALDO] [float] NOT NULL,
	[C5_X_DTAPR] [varchar](8) NOT NULL,
	[C5_X_HRAPR] [varchar](8) NOT NULL,
	[C5_X_CDAPR] [varchar](6) NOT NULL,
	[C5_X_NOAPR] [varchar](40) NOT NULL,
	[C5_X_OBAPR] [varchar](100) NOT NULL,
	[C5_X_SDAPR] [float] NOT NULL,
	[C5_X_LGAPR] [varchar](120) NOT NULL,
	[C5_X_DESCO] [varchar](1) NOT NULL,
	[C5_TXREF] [float] NOT NULL,
	[C5_DTTXREF] [varchar](8) NOT NULL,
	[C5_MOEDTIT] [float] NOT NULL,
	[C5_X_AGLPD] [varchar](6) NOT NULL,
	[C5_X_BALCA] [varchar](1) NOT NULL,
	[C5_X_CDNSU] [varchar](20) NOT NULL,
	[C5_X_CDAUT] [varchar](30) NOT NULL,
	[C5_ESTPRES] [varchar](2) NOT NULL,
	[C5_DTLANC] [varchar](8) NOT NULL,
	[C5_FECENT] [varchar](8) NOT NULL,
	[C5_SOLOPC] [varchar](1) NOT NULL,
	[C5_SUGENT] [varchar](8) NOT NULL,
	[C5_CODED] [varchar](15) NOT NULL,
	[C5_NUMPR] [varchar](15) NOT NULL,
	[C5_PREPEMB] [varchar](1) NOT NULL,
	[C5_OBRA] [varchar](10) NOT NULL,
	[C5_X_ARMAZ] [varchar](2) NOT NULL,
	[C5_ORIGEM] [varchar](15) NOT NULL,
	[C5_INDPRES] [varchar](1) NOT NULL,
	[C5_NUMENT] [varchar](9) NOT NULL,
	[C5_DTESERV] [varchar](8) NOT NULL,
	[C5_NATUREZ] [varchar](10) NOT NULL,
 CONSTRAINT [SC5010_PK] PRIMARY KEY CLUSTERED 
(
	[R_E_C_N_O_] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SC6010]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SC6010](
	[C6_FILIAL] [varchar](2) NOT NULL,
	[C6_ITEM] [varchar](2) NOT NULL,
	[C6_PRODUTO] [varchar](15) NOT NULL,
	[C6_UM] [varchar](2) NOT NULL,
	[C6_QTDVEN] [float] NOT NULL,
	[C6_PRCVEN] [float] NOT NULL,
	[C6_VALOR] [float] NOT NULL,
	[C6_QTDLIB] [float] NOT NULL,
	[C6_QTDLIB2] [float] NOT NULL,
	[C6_SEGUM] [varchar](2) NOT NULL,
	[C6_TES] [varchar](3) NOT NULL,
	[C6_UNSVEN] [float] NOT NULL,
	[C6_LOCAL] [varchar](2) NOT NULL,
	[C6_CF] [varchar](5) NOT NULL,
	[C6_QTDENT] [float] NOT NULL,
	[C6_QTDENT2] [float] NOT NULL,
	[C6_CLI] [varchar](6) NOT NULL,
	[C6_DESCONT] [float] NOT NULL,
	[C6_VALDESC] [float] NOT NULL,
	[C6_ENTREG] [varchar](8) NOT NULL,
	[C6_LA] [varchar](8) NOT NULL,
	[C6_LOJA] [varchar](2) NOT NULL,
	[C6_NOTA] [varchar](9) NOT NULL,
	[C6_SERIE] [varchar](3) NOT NULL,
	[C6_DATFAT] [varchar](8) NOT NULL,
	[C6_NUM] [varchar](6) NOT NULL,
	[C6_COMIS1] [float] NOT NULL,
	[C6_COMIS2] [float] NOT NULL,
	[C6_COMIS3] [float] NOT NULL,
	[C6_COMIS4] [float] NOT NULL,
	[C6_COMIS5] [float] NOT NULL,
	[C6_PEDCLI] [varchar](9) NOT NULL,
	[C6_DESCRI] [varchar](50) NOT NULL,
	[C6_PRUNIT] [float] NOT NULL,
	[C6_BLOQUEI] [varchar](2) NOT NULL,
	[C6_RESERVA] [varchar](6) NOT NULL,
	[C6_OP] [varchar](2) NOT NULL,
	[C6_OK] [varchar](2) NOT NULL,
	[C6_NFORI] [varchar](9) NOT NULL,
	[C6_SERIORI] [varchar](3) NOT NULL,
	[C6_ITEMORI] [varchar](4) NOT NULL,
	[C6_IPIDEV] [float] NOT NULL,
	[C6_IDENTB6] [varchar](6) NOT NULL,
	[C6_BLQ] [varchar](2) NOT NULL,
	[C6_PICMRET] [float] NOT NULL,
	[C6_CODISS] [varchar](9) NOT NULL,
	[C6_GRADE] [varchar](1) NOT NULL,
	[C6_ITEMGRD] [varchar](3) NOT NULL,
	[C6_LOTECTL] [varchar](10) NOT NULL,
	[C6_NUMLOTE] [varchar](6) NOT NULL,
	[C6_DTVALID] [varchar](8) NOT NULL,
	[C6_NUMORC] [varchar](8) NOT NULL,
	[C6_CHASSI] [varchar](17) NOT NULL,
	[C6_OPC] [varchar](80) NOT NULL,
	[C6_LOCALIZ] [varchar](15) NOT NULL,
	[C6_NUMSERI] [varchar](20) NOT NULL,
	[C6_NUMOP] [varchar](6) NOT NULL,
	[C6_ITEMOP] [varchar](2) NOT NULL,
	[C6_CLASFIS] [varchar](3) NOT NULL,
	[C6_QTDRESE] [float] NOT NULL,
	[C6_CONTRAT] [varchar](6) NOT NULL,
	[C6_NUMOS] [varchar](10) NOT NULL,
	[C6_NUMOSFA] [varchar](10) NOT NULL,
	[C6_CODFAB] [varchar](6) NOT NULL,
	[C6_LOJAFA] [varchar](2) NOT NULL,
	[C6_ITEMCON] [varchar](2) NOT NULL,
	[C6_TPOP] [varchar](1) NOT NULL,
	[C6_REVISAO] [varchar](3) NOT NULL,
	[C6_SERVIC] [varchar](3) NOT NULL,
	[C6_ENDPAD] [varchar](15) NOT NULL,
	[C6_TPESTR] [varchar](6) NOT NULL,
	[C6_CONTRT] [varchar](15) NOT NULL,
	[C6_TPCONTR] [varchar](1) NOT NULL,
	[C6_ITCONTR] [varchar](2) NOT NULL,
	[C6_GEROUPV] [varchar](1) NOT NULL,
	[C6_PROJPMS] [varchar](10) NOT NULL,
	[C6_EDTPMS] [varchar](12) NOT NULL,
	[C6_TASKPMS] [varchar](12) NOT NULL,
	[C6_TRT] [varchar](3) NOT NULL,
	[C6_QTDEMP] [float] NOT NULL,
	[C6_QTDEMP2] [float] NOT NULL,
	[C6_PROJET] [varchar](6) NOT NULL,
	[C6_ITPROJ] [varchar](2) NOT NULL,
	[C6_POTENCI] [float] NOT NULL,
	[C6_LICITA] [varchar](6) NOT NULL,
	[C6_REGWMS] [varchar](1) NOT NULL,
	[C6_MOPC] [image] NULL,
	[C6_NUMCP] [varchar](6) NOT NULL,
	[C6_NUMSC] [varchar](6) NOT NULL,
	[C6_ITEMSC] [varchar](4) NOT NULL,
	[C6_SUGENTR] [varchar](8) NOT NULL,
	[C6_ITEMED] [varchar](3) NOT NULL,
	[C6_ABSCINS] [float] NOT NULL,
	[C6_ABATISS] [float] NOT NULL,
	[C6_ABATMAT] [float] NOT NULL,
	[C6_FUNRURA] [float] NOT NULL,
	[C6_FETAB] [float] NOT NULL,
	[C6_CODROM] [varchar](6) NOT NULL,
	[D_E_L_E_T_] [varchar](1) NOT NULL,
	[R_E_C_N_O_] [int] NOT NULL,
	[R_E_C_D_E_L_] [int] NOT NULL,
	[C6_X_TABEL] [varchar](3) NOT NULL,
	[C6_X_TXTCO] [varchar](70) NOT NULL,
	[C6_X_FLGCO] [varchar](1) NOT NULL,
	[C6_X_LICIT] [image] NULL,
	[C6_X_PRCV] [float] NOT NULL,
	[C6_X_PRUN] [float] NOT NULL,
	[C6_X_TES] [varchar](3) NOT NULL,
	[C6_X_TCOM] [varchar](1) NOT NULL,
	[C6_X_OBS] [varchar](80) NOT NULL,
	[C6_X_QTDCF] [float] NOT NULL,
	[C6_X_QTDOR] [float] NOT NULL,
	[C6_X_CODPM] [varchar](6) NOT NULL,
	[C6_X_NOMPM] [varchar](20) NOT NULL,
	[C6_X_OBSPM] [varchar](60) NOT NULL,
	[C6_X_PRCPM] [float] NOT NULL,
	[C6_X_ITEM] [varchar](3) NOT NULL,
	[C6_X_PROMO] [varchar](1) NOT NULL,
	[C6_X_FLGPM] [varchar](1) NOT NULL,
	[C6_X_PRMIN] [float] NOT NULL,
	[C6_X_CODFR] [varchar](10) NOT NULL,
	[C6_X_PRVEN] [float] NOT NULL,
	[C6_X_PREXP] [float] NOT NULL,
	[C6_X_DESCP] [float] NOT NULL,
	[C6_TPDEDUZ] [varchar](1) NOT NULL,
	[C6_MOTDED] [varchar](1) NOT NULL,
	[C6_FORDED] [varchar](6) NOT NULL,
	[C6_LOJDED] [varchar](2) NOT NULL,
	[C6_SERDED] [varchar](3) NOT NULL,
	[C6_NFDED] [varchar](9) NOT NULL,
	[C6_VLNFD] [float] NOT NULL,
	[C6_PCDED] [float] NOT NULL,
	[C6_VLDED] [float] NOT NULL,
	[C6__PRUNIT] [float] NOT NULL,
	[C6__FLGCOM] [varchar](1) NOT NULL,
	[C6_BASVEIC] [float] NOT NULL,
	[C6_ABATINS] [float] NOT NULL,
	[C6_CODLAN] [varchar](6) NOT NULL,
	[C6_X_CDSZN] [varchar](6) NOT NULL,
	[C6_X_PMSZN] [float] NOT NULL,
	[C6_X_OBSZN] [varchar](140) NOT NULL,
	[C6_X_CDSZM] [varchar](6) NOT NULL,
	[C6_X_DTSZM] [varchar](8) NOT NULL,
	[C6_X_HRSZM] [varchar](8) NOT NULL,
	[C6_X_OBSZM] [varchar](150) NOT NULL,
	[C6_X_SALDO] [float] NOT NULL,
	[C6_X_AUTMC] [varchar](1) NOT NULL,
	[C6_X_MINTB] [float] NOT NULL,
	[C6_X_PRSUG] [float] NOT NULL,
	[C6_X_MARGE] [float] NOT NULL,
	[C6_X_APRMC] [float] NOT NULL,
	[C6_X_DTAMC] [varchar](8) NOT NULL,
	[C6_X_HRAMC] [varchar](8) NOT NULL,
	[C6_X_USAMC] [varchar](6) NOT NULL,
	[C6_TNATREC] [varchar](4) NOT NULL,
	[C6_CNATREC] [varchar](3) NOT NULL,
	[C6_GRPNATR] [varchar](2) NOT NULL,
	[C6_DTFIMNT] [varchar](8) NOT NULL,
	[C6_ITEMPC] [varchar](6) NOT NULL,
	[C6_NUMPCOM] [varchar](15) NOT NULL,
	[C6_PEDCOM] [varchar](6) NOT NULL,
	[C6_ITPC] [varchar](4) NOT NULL,
	[C6_FILPED] [varchar](2) NOT NULL,
	[C6_PROGRAM] [varchar](10) NOT NULL,
	[C6_TURNO] [varchar](1) NOT NULL,
	[C6_PVCOMOP] [varchar](1) NOT NULL,
	[C6_VDMOST] [varchar](1) NOT NULL,
	[C6_VDOBS] [image] NULL,
	[C6_RATEIO] [varchar](1) NOT NULL,
	[C6_ITLPRE] [varchar](3) NOT NULL,
	[C6_D1SERIE] [varchar](3) NOT NULL,
	[C6_D1DOC] [varchar](15) NOT NULL,
	[C6_CODLPRE] [varchar](6) NOT NULL,
	[C6_D1ITEM] [varchar](4) NOT NULL,
	[C6_VLIMPOR] [float] NOT NULL,
	[C6_FCICOD] [varchar](36) NOT NULL,
	[C6_CODINF] [varchar](6) NOT NULL,
	[C6_HORENT] [varchar](4) NOT NULL,
	[C6_PMSID] [varchar](10) NOT NULL,
	[C6_PEDVINC] [varchar](6) NOT NULL,
	[C6_PRODFIN] [varchar](15) NOT NULL,
	[C6_REVPROD] [varchar](3) NOT NULL,
 CONSTRAINT [SC6010_PK] PRIMARY KEY CLUSTERED 
(
	[R_E_C_N_O_] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SD1010]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SD1010](
	[D1_FILIAL] [varchar](2) NOT NULL,
	[D1_ITEM] [varchar](4) NOT NULL,
	[D1_COD] [varchar](15) NOT NULL,
	[D1_UM] [varchar](2) NOT NULL,
	[D1_SEGUM] [varchar](2) NOT NULL,
	[D1_QUANT] [float] NOT NULL,
	[D1_VUNIT] [float] NOT NULL,
	[D1_TOTAL] [float] NOT NULL,
	[D1_VALIPI] [float] NOT NULL,
	[D1_VALICM] [float] NOT NULL,
	[D1_TES] [varchar](3) NOT NULL,
	[D1_CF] [varchar](5) NOT NULL,
	[D1_DESC] [float] NOT NULL,
	[D1_IPI] [float] NOT NULL,
	[D1_PICM] [float] NOT NULL,
	[D1_PESO] [float] NOT NULL,
	[D1_CONTA] [varchar](20) NOT NULL,
	[D1_ITEMCTA] [varchar](11) NOT NULL,
	[D1_CC] [varchar](9) NOT NULL,
	[D1_OP] [varchar](13) NOT NULL,
	[D1_PEDIDO] [varchar](6) NOT NULL,
	[D1_ITEMPC] [varchar](4) NOT NULL,
	[D1_FORNECE] [varchar](6) NOT NULL,
	[D1_LOJA] [varchar](2) NOT NULL,
	[D1_LOCAL] [varchar](2) NOT NULL,
	[D1_DOC] [varchar](9) NOT NULL,
	[D1_EMISSAO] [varchar](8) NOT NULL,
	[D1_DTDIGIT] [varchar](8) NOT NULL,
	[D1_GRUPO] [varchar](4) NOT NULL,
	[D1_TIPO] [varchar](1) NOT NULL,
	[D1_SERIE] [varchar](3) NOT NULL,
	[D1_CUSTO2] [float] NOT NULL,
	[D1_CUSTO3] [float] NOT NULL,
	[D1_CUSTO4] [float] NOT NULL,
	[D1_CUSTO5] [float] NOT NULL,
	[D1_TP] [varchar](2) NOT NULL,
	[D1_QTSEGUM] [float] NOT NULL,
	[D1_NUMSEQ] [varchar](6) NOT NULL,
	[D1_DATACUS] [varchar](8) NOT NULL,
	[D1_NFORI] [varchar](9) NOT NULL,
	[D1_SERIORI] [varchar](3) NOT NULL,
	[D1_ITEMORI] [varchar](4) NOT NULL,
	[D1_QTDEDEV] [float] NOT NULL,
	[D1_VALDEV] [float] NOT NULL,
	[D1_ORIGLAN] [varchar](2) NOT NULL,
	[D1_ICMSRET] [float] NOT NULL,
	[D1_BRICMS] [float] NOT NULL,
	[D1_NUMCQ] [varchar](6) NOT NULL,
	[D1_DATORI] [varchar](8) NOT NULL,
	[D1_BASEICM] [float] NOT NULL,
	[D1_VALDESC] [float] NOT NULL,
	[D1_IDENTB6] [varchar](6) NOT NULL,
	[D1_LOTEFOR] [varchar](18) NOT NULL,
	[D1_SKIPLOT] [varchar](1) NOT NULL,
	[D1_BASEIPI] [float] NOT NULL,
	[D1_SEQCALC] [varchar](14) NOT NULL,
	[D1_LOTECTL] [varchar](10) NOT NULL,
	[D1_NUMLOTE] [varchar](6) NOT NULL,
	[D1_DTVALID] [varchar](8) NOT NULL,
	[D1_PLACA] [varchar](7) NOT NULL,
	[D1_CHASSI] [varchar](17) NOT NULL,
	[D1_ANOFAB] [varchar](2) NOT NULL,
	[D1_MODFAB] [varchar](2) NOT NULL,
	[D1_MODELO] [varchar](15) NOT NULL,
	[D1_COMBUST] [varchar](10) NOT NULL,
	[D1_COR] [varchar](3) NOT NULL,
	[D1_EQUIPS] [varchar](3) NOT NULL,
	[D1_FORMUL] [varchar](1) NOT NULL,
	[D1_II] [float] NOT NULL,
	[D1_TEC] [varchar](16) NOT NULL,
	[D1_CONHEC] [varchar](17) NOT NULL,
	[D1_NUMPV] [varchar](6) NOT NULL,
	[D1_ITEMPV] [varchar](2) NOT NULL,
	[D1_CUSFF1] [float] NOT NULL,
	[D1_CUSFF2] [float] NOT NULL,
	[D1_CUSFF3] [float] NOT NULL,
	[D1_CUSFF4] [float] NOT NULL,
	[D1_CUSFF5] [float] NOT NULL,
	[D1_CODCIAP] [varchar](6) NOT NULL,
	[D1_CLASFIS] [varchar](3) NOT NULL,
	[D1_BASIMP1] [float] NOT NULL,
	[D1_REMITO] [varchar](9) NOT NULL,
	[D1_SERIREM] [varchar](3) NOT NULL,
	[D1_CUSTO] [float] NOT NULL,
	[D1_BASIMP3] [float] NOT NULL,
	[D1_BASIMP4] [float] NOT NULL,
	[D1_BASIMP5] [float] NOT NULL,
	[D1_BASIMP6] [float] NOT NULL,
	[D1_VALIMP1] [float] NOT NULL,
	[D1_VALIMP2] [float] NOT NULL,
	[D1_VALIMP3] [float] NOT NULL,
	[D1_VALIMP4] [float] NOT NULL,
	[D1_VALIMP5] [float] NOT NULL,
	[D1_VALIMP6] [float] NOT NULL,
	[D1_CBASEAF] [varchar](14) NOT NULL,
	[D1_ICMSCOM] [float] NOT NULL,
	[D1_CIF] [float] NOT NULL,
	[D1_ITEMREM] [varchar](4) NOT NULL,
	[D1_BASIMP2] [float] NOT NULL,
	[D1_TIPO_NF] [varchar](1) NOT NULL,
	[D1_ALQIMP1] [float] NOT NULL,
	[D1_ALQIMP2] [float] NOT NULL,
	[D1_ALQIMP3] [float] NOT NULL,
	[D1_ALQIMP4] [float] NOT NULL,
	[D1_ALQIMP5] [float] NOT NULL,
	[D1_ALQIMP6] [float] NOT NULL,
	[D1_QTDPEDI] [float] NOT NULL,
	[D1_VALFRE] [float] NOT NULL,
	[D1_RATEIO] [varchar](1) NOT NULL,
	[D1_SEGURO] [float] NOT NULL,
	[D1_DESPESA] [float] NOT NULL,
	[D1_BASEIRR] [float] NOT NULL,
	[D1_ALIQIRR] [float] NOT NULL,
	[D1_VALIRR] [float] NOT NULL,
	[D1_BASEISS] [float] NOT NULL,
	[D1_ALIQISS] [float] NOT NULL,
	[D1_VALISS] [float] NOT NULL,
	[D1_BASEINS] [float] NOT NULL,
	[D1_ALIQINS] [float] NOT NULL,
	[D1_VALINS] [float] NOT NULL,
	[D1_CUSORI] [float] NOT NULL,
	[D1_LOCPAD] [varchar](6) NOT NULL,
	[D1_CLVL] [varchar](20) NOT NULL,
	[D1_ORDEM] [varchar](6) NOT NULL,
	[D1_SERVIC] [varchar](3) NOT NULL,
	[D1_STSERV] [varchar](1) NOT NULL,
	[D1_ENDER] [varchar](15) NOT NULL,
	[D1_TPESTR] [varchar](6) NOT NULL,
	[D1_REGWMS] [varchar](1) NOT NULL,
	[D1_TIPODOC] [varchar](2) NOT NULL,
	[D1_POTENCI] [float] NOT NULL,
	[D1_TRT] [varchar](3) NOT NULL,
	[D1_TESACLA] [varchar](3) NOT NULL,
	[D1_NUMDESP] [varchar](16) NOT NULL,
	[D1_ORIGEM] [varchar](3) NOT NULL,
	[D1_GRADE] [varchar](1) NOT NULL,
	[D1_ITEMGRD] [varchar](3) NOT NULL,
	[D1_DESCICM] [float] NOT NULL,
	[D1_CODISS] [varchar](9) NOT NULL,
	[D1_BASEPS3] [float] NOT NULL,
	[D1_ALIQPS3] [float] NOT NULL,
	[D1_VALPS3] [float] NOT NULL,
	[D1_BASECF3] [float] NOT NULL,
	[D1_ALIQCF3] [float] NOT NULL,
	[D1_VALCF3] [float] NOT NULL,
	[D1_CFPS] [varchar](6) NOT NULL,
	[D1_VALANTI] [float] NOT NULL,
	[D1_NFVINC] [varchar](9) NOT NULL,
	[D1_SERVINC] [varchar](3) NOT NULL,
	[D1_ITMVINC] [varchar](4) NOT NULL,
	[D1_ICMSDIF] [float] NOT NULL,
	[D1_ESTCRED] [float] NOT NULL,
	[D1_PRUNDA] [float] NOT NULL,
	[D1_BASESES] [float] NOT NULL,
	[D1_VALSES] [float] NOT NULL,
	[D1_ALIQSES] [float] NOT NULL,
	[D1_GARANTI] [varchar](1) NOT NULL,
	[D1_CRPRESC] [float] NOT NULL,
	[D1_RGESPST] [varchar](1) NOT NULL,
	[D1_VALFDS] [float] NOT NULL,
	[D1_PRFDSUL] [float] NOT NULL,
	[D1_UFERMS] [float] NOT NULL,
	[D_E_L_E_T_] [varchar](1) NOT NULL,
	[R_E_C_N_O_] [int] NOT NULL,
	[R_E_C_D_E_L_] [int] NOT NULL,
	[D1_TRANSIT] [varchar](1) NOT NULL,
	[D1_ABATISS] [float] NOT NULL,
	[D1_ABATMAT] [float] NOT NULL,
	[D1_ICMNDES] [float] NOT NULL,
	[D1_BASNDES] [float] NOT NULL,
	[D1_CRPRSIM] [float] NOT NULL,
	[D1_ALIQSOL] [float] NOT NULL,
	[D1_ALIQII] [float] NOT NULL,
	[D1_X_IMETQ] [varchar](1) NOT NULL,
	[D1_X_VEND1] [varchar](6) NOT NULL,
	[D1_X_MOTDV] [varchar](3) NOT NULL,
	[D1_DFABRIC] [varchar](8) NOT NULL,
	[D1_MARGEM] [float] NOT NULL,
	[D1_SLDDEP] [float] NOT NULL,
	[D1_BASEFAB] [float] NOT NULL,
	[D1_ALIQFAB] [float] NOT NULL,
	[D1_VALFAB] [float] NOT NULL,
	[D1_BASEFAC] [float] NOT NULL,
	[D1_ALIQFAC] [float] NOT NULL,
	[D1_VALFAC] [float] NOT NULL,
	[D1_BASEFET] [float] NOT NULL,
	[D1_ALIQFET] [float] NOT NULL,
	[D1_VALFET] [float] NOT NULL,
	[D1_BASEFUN] [float] NOT NULL,
	[D1_ALIQFUN] [float] NOT NULL,
	[D1_VALFUN] [float] NOT NULL,
	[D1_ABATINS] [float] NOT NULL,
	[D1_AVLINSS] [float] NOT NULL,
	[D1_CODLAN] [varchar](6) NOT NULL,
	[D1_CRPREPR] [float] NOT NULL,
	[D1_CODBAIX] [varchar](6) NOT NULL,
	[D1_TNATREC] [varchar](4) NOT NULL,
	[D1_CNATREC] [varchar](3) NOT NULL,
	[D1_GRUPONC] [varchar](2) NOT NULL,
	[D1_DTFIMNT] [varchar](8) NOT NULL,
	[D1_VALINA] [float] NOT NULL,
	[D1_BASEINA] [float] NOT NULL,
	[D1_ALIQINA] [float] NOT NULL,
	[D1_BASEPIS] [float] NOT NULL,
	[D1_BASECOF] [float] NOT NULL,
	[D1_BASECSL] [float] NOT NULL,
	[D1_VALPIS] [float] NOT NULL,
	[D1_VALCOF] [float] NOT NULL,
	[D1_VALCSL] [float] NOT NULL,
	[D1_ALQPIS] [float] NOT NULL,
	[D1_ALQCOF] [float] NOT NULL,
	[D1_ALQCSL] [float] NOT NULL,
	[D1_VLINCMG] [float] NOT NULL,
	[D1_PRINCMG] [float] NOT NULL,
	[D1_OKISS] [varchar](2) NOT NULL,
	[D1_VALCMAJ] [float] NOT NULL,
	[D1_VLSENAR] [float] NOT NULL,
	[D1_BSSENAR] [float] NOT NULL,
	[D1_ALSENAR] [float] NOT NULL,
	[D1_VALACRS] [float] NOT NULL,
	[D1_PCCENTR] [varchar](6) NOT NULL,
	[D1_ITPCCEN] [varchar](4) NOT NULL,
	[D1_QTPCCEN] [float] NOT NULL,
	[D1_CRDZFM] [float] NOT NULL,
	[D1_QTDCONF] [float] NOT NULL,
	[D1_CODNOR] [varchar](6) NOT NULL,
	[D1_CONBAR] [varchar](1) NOT NULL,
	[D1_CUSRP4] [float] NOT NULL,
	[D1_CUSRP1] [float] NOT NULL,
	[D1_CUSRP5] [float] NOT NULL,
	[D1_CUSRP2] [float] NOT NULL,
	[D1_OPERADO] [varchar](3) NOT NULL,
	[D1_CUSRP3] [float] NOT NULL,
	[D1_PROJ] [varchar](10) NOT NULL,
	[D1_VALPMAJ] [float] NOT NULL,
	[D1_IDCFC] [varchar](20) NOT NULL,
	[D1_CONIMP] [float] NOT NULL,
	[D1_FCICOD] [varchar](36) NOT NULL,
	[D1_VLCIDE] [float] NOT NULL,
	[D1_BASECID] [float] NOT NULL,
	[D1_ALQCIDE] [float] NOT NULL,
	[D1_VALCPM] [float] NOT NULL,
	[D1_BASECPM] [float] NOT NULL,
	[D1_ALQCPM] [float] NOT NULL,
	[D1_BASEFMD] [float] NOT NULL,
	[D1_ALQFMD] [float] NOT NULL,
	[D1_VALFMD] [float] NOT NULL,
	[D1_CODFIS] [varchar](15) NOT NULL,
	[D1_IDSB5] [varchar](20) NOT NULL,
	[D1_IDSB1] [varchar](20) NOT NULL,
	[D1_IDSBZ] [varchar](20) NOT NULL,
	[D1_REVISAO] [varchar](3) NOT NULL,
	[D1_IDSF7] [varchar](20) NOT NULL,
	[D1_IDSF4] [varchar](20) NOT NULL,
	[D1_FILORI] [varchar](2) NOT NULL,
	[D1_DESCZFR] [float] NOT NULL,
	[D1_DESCZFP] [float] NOT NULL,
	[D1_DESCZFC] [float] NOT NULL,
	[D1_VALFMP] [float] NOT NULL,
	[D1_BASEFMP] [float] NOT NULL,
	[D1_ALQFMP] [float] NOT NULL,
	[D1_GRPCST] [varchar](3) NOT NULL,
	[D1_BASECPB] [float] NOT NULL,
	[D1_VALCPB] [float] NOT NULL,
	[D1_ALIQCPB] [float] NOT NULL,
	[D1_DIFAL] [float] NOT NULL,
	[D1_PDORI] [float] NOT NULL,
	[D1_PDDES] [float] NOT NULL,
	[D1_ALFCCMP] [float] NOT NULL,
	[D1_ALIQCMP] [float] NOT NULL,
	[D1_BASEDES] [float] NOT NULL,
	[D1_VFCPDIF] [float] NOT NULL,
	[D1_FTRICMS] [float] NOT NULL,
	[D1_VRDICMS] [float] NOT NULL,
	[D1_VALFUND] [float] NOT NULL,
	[D1_BASFUND] [float] NOT NULL,
	[D1_ALIFUND] [float] NOT NULL,
	[D1_VALIMA] [float] NOT NULL,
	[D1_BASIMA] [float] NOT NULL,
	[D1_ALIIMA] [float] NOT NULL,
	[D1_VALFASE] [float] NOT NULL,
	[D1_BASFASE] [float] NOT NULL,
	[D1_ALIFASE] [float] NOT NULL,
	[D1_VLSLXML] [float] NOT NULL,
	[D1_CSOSN] [varchar](3) NOT NULL,
	[D1_BASEINP] [float] NOT NULL,
	[D1_PERCINP] [float] NOT NULL,
	[D1_VALINP] [float] NOT NULL,
	[D1_ALQFECP] [float] NOT NULL,
	[D1_VALFECP] [float] NOT NULL,
	[D1_VFECPST] [float] NOT NULL,
 CONSTRAINT [SD1010_PK] PRIMARY KEY CLUSTERED 
(
	[R_E_C_N_O_] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SD2010]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SD2010](
	[D2_FILIAL] [varchar](2) NOT NULL,
	[D2_ITEM] [varchar](2) NOT NULL,
	[D2_COD] [varchar](15) NOT NULL,
	[D2_UM] [varchar](2) NOT NULL,
	[D2_SEGUM] [varchar](2) NOT NULL,
	[D2_QUANT] [float] NOT NULL,
	[D2_PRCVEN] [float] NOT NULL,
	[D2_TOTAL] [float] NOT NULL,
	[D2_VALIPI] [float] NOT NULL,
	[D2_VALICM] [float] NOT NULL,
	[D2_TES] [varchar](3) NOT NULL,
	[D2_CF] [varchar](5) NOT NULL,
	[D2_DESC] [float] NOT NULL,
	[D2_IPI] [float] NOT NULL,
	[D2_PICM] [float] NOT NULL,
	[D2_PESO] [float] NOT NULL,
	[D2_CONTA] [varchar](20) NOT NULL,
	[D2_OP] [varchar](13) NOT NULL,
	[D2_PEDIDO] [varchar](6) NOT NULL,
	[D2_ITEMPV] [varchar](2) NOT NULL,
	[D2_CLIENTE] [varchar](6) NOT NULL,
	[D2_LOJA] [varchar](2) NOT NULL,
	[D2_LOCAL] [varchar](2) NOT NULL,
	[D2_DOC] [varchar](9) NOT NULL,
	[D2_SERIE] [varchar](3) NOT NULL,
	[D2_GRUPO] [varchar](4) NOT NULL,
	[D2_TP] [varchar](2) NOT NULL,
	[D2_EMISSAO] [varchar](8) NOT NULL,
	[D2_CUSTO1] [float] NOT NULL,
	[D2_CUSTO2] [float] NOT NULL,
	[D2_CUSTO3] [float] NOT NULL,
	[D2_CUSTO4] [float] NOT NULL,
	[D2_CUSTO5] [float] NOT NULL,
	[D2_PRUNIT] [float] NOT NULL,
	[D2_QTSEGUM] [float] NOT NULL,
	[D2_NUMSEQ] [varchar](6) NOT NULL,
	[D2_EST] [varchar](2) NOT NULL,
	[D2_DESCON] [float] NOT NULL,
	[D2_TIPO] [varchar](1) NOT NULL,
	[D2_NFORI] [varchar](9) NOT NULL,
	[D2_SERIORI] [varchar](3) NOT NULL,
	[D2_QTDEDEV] [float] NOT NULL,
	[D2_VALDEV] [float] NOT NULL,
	[D2_ORIGLAN] [varchar](2) NOT NULL,
	[D2_BRICMS] [float] NOT NULL,
	[D2_BASEORI] [float] NOT NULL,
	[D2_BASEICM] [float] NOT NULL,
	[D2_VALACRS] [float] NOT NULL,
	[D2_IDENTB6] [varchar](6) NOT NULL,
	[D2_CODISS] [varchar](9) NOT NULL,
	[D2_GRADE] [varchar](1) NOT NULL,
	[D2_SEQCALC] [varchar](14) NOT NULL,
	[D2_ICMSRET] [float] NOT NULL,
	[D2_COMIS1] [float] NOT NULL,
	[D2_COMIS2] [float] NOT NULL,
	[D2_COMIS3] [float] NOT NULL,
	[D2_COMIS4] [float] NOT NULL,
	[D2_COMIS5] [float] NOT NULL,
	[D2_LOTECTL] [varchar](10) NOT NULL,
	[D2_NUMLOTE] [varchar](6) NOT NULL,
	[D2_DTVALID] [varchar](8) NOT NULL,
	[D2_DESCZFR] [float] NOT NULL,
	[D2_PDV] [varchar](10) NOT NULL,
	[D2_NUMSERI] [varchar](20) NOT NULL,
	[D2_DTLCTCT] [varchar](8) NOT NULL,
	[D2_CUSFF1] [float] NOT NULL,
	[D2_CUSFF2] [float] NOT NULL,
	[D2_CUSFF3] [float] NOT NULL,
	[D2_CUSFF4] [float] NOT NULL,
	[D2_CUSFF5] [float] NOT NULL,
	[D2_CLASFIS] [varchar](3) NOT NULL,
	[D2_BASIMP1] [float] NOT NULL,
	[D2_REMITO] [varchar](9) NOT NULL,
	[D2_SERIREM] [varchar](3) NOT NULL,
	[D2_BASIMP2] [float] NOT NULL,
	[D2_BASIMP3] [float] NOT NULL,
	[D2_ITEMREM] [varchar](2) NOT NULL,
	[D2_BASIMP4] [float] NOT NULL,
	[D2_BASIMP5] [float] NOT NULL,
	[D2_BASIMP6] [float] NOT NULL,
	[D2_VALIMP1] [float] NOT NULL,
	[D2_VALIMP2] [float] NOT NULL,
	[D2_VALIMP3] [float] NOT NULL,
	[D2_VALIMP4] [float] NOT NULL,
	[D2_VALIMP5] [float] NOT NULL,
	[D2_VALIMP6] [float] NOT NULL,
	[D2_ITEMORI] [varchar](4) NOT NULL,
	[D2_CODFAB] [varchar](6) NOT NULL,
	[D2_LOJAFA] [varchar](2) NOT NULL,
	[D2_ALQIMP1] [float] NOT NULL,
	[D2_ALQIMP2] [float] NOT NULL,
	[D2_ALQIMP3] [float] NOT NULL,
	[D2_ALQIMP4] [float] NOT NULL,
	[D2_ALQIMP5] [float] NOT NULL,
	[D2_ALQIMP6] [float] NOT NULL,
	[D2_CCUSTO] [varchar](9) NOT NULL,
	[D2_ITEMCC] [varchar](11) NOT NULL,
	[D2_LOCALIZ] [varchar](15) NOT NULL,
	[D2_ENVCNAB] [varchar](8) NOT NULL,
	[D2_ALIQINS] [float] NOT NULL,
	[D2_ABSCINS] [float] NOT NULL,
	[D2_PREEMB] [varchar](20) NOT NULL,
	[D2_ALIQISS] [float] NOT NULL,
	[D2_BASEIPI] [float] NOT NULL,
	[D2_BASEISS] [float] NOT NULL,
	[D2_VALISS] [float] NOT NULL,
	[D2_SEGURO] [float] NOT NULL,
	[D2_VALFRE] [float] NOT NULL,
	[D2_TPDCENV] [varchar](1) NOT NULL,
	[D2_DESPESA] [float] NOT NULL,
	[D2_OK] [varchar](2) NOT NULL,
	[D2_CLVL] [varchar](20) NOT NULL,
	[D2_BASEINS] [float] NOT NULL,
	[D2_ICMFRET] [float] NOT NULL,
	[D2_SERVIC] [varchar](3) NOT NULL,
	[D2_STSERV] [varchar](1) NOT NULL,
	[D2_VALINS] [float] NOT NULL,
	[D2_PROJPMS] [varchar](10) NOT NULL,
	[D2_EDTPMS] [varchar](12) NOT NULL,
	[D2_TASKPMS] [varchar](12) NOT NULL,
	[D2_LICITA] [varchar](6) NOT NULL,
	[D2_VARPRUN] [float] NOT NULL,
	[D2_FORMUL] [varchar](1) NOT NULL,
	[D2_TIPODOC] [varchar](2) NOT NULL,
	[D2_VAC] [float] NOT NULL,
	[D2_TIPOREM] [varchar](1) NOT NULL,
	[D2_QTDEFAT] [float] NOT NULL,
	[D2_QTDAFAT] [float] NOT NULL,
	[D2_SEQUEN] [varchar](2) NOT NULL,
	[D2_POTENCI] [float] NOT NULL,
	[D2_TPESTR] [varchar](6) NOT NULL,
	[D2_VALBRUT] [float] NOT NULL,
	[D2_REGWMS] [varchar](1) NOT NULL,
	[D2_DTDIGIT] [varchar](8) NOT NULL,
	[D2_NUMCP] [varchar](6) NOT NULL,
	[D2_BASEPS3] [float] NOT NULL,
	[D2_ALIQPS3] [float] NOT NULL,
	[D2_VALPS3] [float] NOT NULL,
	[D2_BASECF3] [float] NOT NULL,
	[D2_ALIQCF3] [float] NOT NULL,
	[D2_VALCF3] [float] NOT NULL,
	[D2_DESCICM] [float] NOT NULL,
	[D2_CFPS] [varchar](6) NOT NULL,
	[D2_BASETST] [float] NOT NULL,
	[D2_ALIQTST] [float] NOT NULL,
	[D2_VALTST] [float] NOT NULL,
	[D2_ESTCRED] [float] NOT NULL,
	[D2_VALFDS] [float] NOT NULL,
	[D2_PRFDSUL] [float] NOT NULL,
	[D2_UFERMS] [float] NOT NULL,
	[D2_ABATISS] [float] NOT NULL,
	[D2_ABATMAT] [float] NOT NULL,
	[D2_BASEIRR] [float] NOT NULL,
	[D2_CODROM] [varchar](6) NOT NULL,
	[D2_PRUNDA] [float] NOT NULL,
	[D2_TRT] [varchar](3) NOT NULL,
	[D_E_L_E_T_] [varchar](1) NOT NULL,
	[R_E_C_N_O_] [int] NOT NULL,
	[R_E_C_D_E_L_] [int] NOT NULL,
	[D2_ALIQSOL] [float] NOT NULL,
	[D2__TOTAL] [float] NOT NULL,
	[D2_CRPRESC] [float] NOT NULL,
	[D2_DESCZFP] [float] NOT NULL,
	[D2_DESCZFC] [float] NOT NULL,
	[D2_BASEFAB] [float] NOT NULL,
	[D2_ALIQFAB] [float] NOT NULL,
	[D2_VALFAB] [float] NOT NULL,
	[D2_BASEFAC] [float] NOT NULL,
	[D2_ALIQFAC] [float] NOT NULL,
	[D2_VALFAC] [float] NOT NULL,
	[D2_BASEFET] [float] NOT NULL,
	[D2_ALIQFET] [float] NOT NULL,
	[D2_VALFET] [float] NOT NULL,
	[D2_MARGEM] [float] NOT NULL,
	[D2_X_FLGIM] [varchar](1) NOT NULL,
	[D2_BASEFUN] [float] NOT NULL,
	[D2_DFABRIC] [varchar](8) NOT NULL,
	[D2_ALIQFUN] [float] NOT NULL,
	[D2_VALFUN] [float] NOT NULL,
	[D2_ABATINS] [float] NOT NULL,
	[D2_VLSENAR] [float] NOT NULL,
	[D2_BSSENAR] [float] NOT NULL,
	[D2_ALSENAR] [float] NOT NULL,
	[D2_CODLAN] [varchar](6) NOT NULL,
	[D2_X_PMSZN] [float] NOT NULL,
	[D2_X_PRUNI] [float] NOT NULL,
	[D2_VALINA] [float] NOT NULL,
	[D2_BASEINA] [float] NOT NULL,
	[D2_ALIQINA] [float] NOT NULL,
	[D2_TNATREC] [varchar](4) NOT NULL,
	[D2_CNATREC] [varchar](3) NOT NULL,
	[D2_GRUPONC] [varchar](2) NOT NULL,
	[D2_DTFIMNT] [varchar](8) NOT NULL,
	[D2_BASEPIS] [float] NOT NULL,
	[D2_BASECOF] [float] NOT NULL,
	[D2_BASECSL] [float] NOT NULL,
	[D2_VALPIS] [float] NOT NULL,
	[D2_VALCOF] [float] NOT NULL,
	[D2_VALCSL] [float] NOT NULL,
	[D2_ALQPIS] [float] NOT NULL,
	[D2_ALQCOF] [float] NOT NULL,
	[D2_ALQCSL] [float] NOT NULL,
	[D2_VLINCMG] [float] NOT NULL,
	[D2_PRINCMG] [float] NOT NULL,
	[D2_CBASEAF] [varchar](14) NOT NULL,
	[D2_VCAT156] [float] NOT NULL,
	[D2_VREINT] [float] NOT NULL,
	[D2_BSREIN] [float] NOT NULL,
	[D2_09CAT17] [float] NOT NULL,
	[D2_16CAT17] [float] NOT NULL,
	[D2_FCICOD] [varchar](36) NOT NULL,
	[D2_CUSRP1] [float] NOT NULL,
	[D2_CUSRP2] [float] NOT NULL,
	[D2_CUSRP3] [float] NOT NULL,
	[D2_CUSRP4] [float] NOT NULL,
	[D2_CUSRP5] [float] NOT NULL,
	[D2_VALIRRF] [float] NOT NULL,
	[D2_ALQIRRF] [float] NOT NULL,
	[D2_ORDSEP] [varchar](6) NOT NULL,
	[D2_RATEIO] [varchar](1) NOT NULL,
	[D2_CODLPRE] [varchar](6) NOT NULL,
	[D2_ITLPRE] [varchar](3) NOT NULL,
	[D2_SITTRIB] [varchar](5) NOT NULL,
	[D2_VLIMPOR] [float] NOT NULL,
	[D2_OKISS] [varchar](10) NOT NULL,
	[D2_TOTIMP] [float] NOT NULL,
	[D2_IDCFC] [varchar](20) NOT NULL,
	[D2_TOTFED] [float] NOT NULL,
	[D2_TOTEST] [float] NOT NULL,
	[D2_TOTMUN] [float] NOT NULL,
	[D2_VALCPM] [float] NOT NULL,
	[D2_BASECPM] [float] NOT NULL,
	[D2_ALQCPM] [float] NOT NULL,
	[D2_VALFMP] [float] NOT NULL,
	[D2_BASEFMP] [float] NOT NULL,
	[D2_ALQFMP] [float] NOT NULL,
	[D2_BASEFMD] [float] NOT NULL,
	[D2_ALQFMD] [float] NOT NULL,
	[D2_VALFMD] [float] NOT NULL,
	[D2_ESPECIE] [varchar](5) NOT NULL,
	[D2_NFCUP] [varchar](9) NOT NULL,
	[D2_ESTOQUE] [varchar](1) NOT NULL,
	[D2_IDSF7] [varchar](20) NOT NULL,
	[D2_IDSF4] [varchar](20) NOT NULL,
	[D2_IDSBZ] [varchar](20) NOT NULL,
	[D2_IDSB5] [varchar](20) NOT NULL,
	[D2_IDSB1] [varchar](20) NOT NULL,
	[D2_PRODFIN] [varchar](15) NOT NULL,
	[D2_REVISAO] [varchar](3) NOT NULL,
	[D2_GRPCST] [varchar](3) NOT NULL,
	[D2_BASECPB] [float] NOT NULL,
	[D2_VALCPB] [float] NOT NULL,
	[D2_ALIQCPB] [float] NOT NULL,
	[D2_ICMSCOM] [float] NOT NULL,
	[D2_DIFAL] [float] NOT NULL,
	[D2_PDORI] [float] NOT NULL,
	[D2_PDDES] [float] NOT NULL,
	[D2_ALFCCMP] [float] NOT NULL,
	[D2_ALIQCMP] [float] NOT NULL,
	[D2_BASEDES] [float] NOT NULL,
	[D2_VFCPDIF] [float] NOT NULL,
	[D2_FTRICMS] [float] NOT NULL,
	[D2_VRDICMS] [float] NOT NULL,
	[D2_VALFUND] [float] NOT NULL,
	[D2_BASFUND] [float] NOT NULL,
	[D2_ALIFUND] [float] NOT NULL,
	[D2_VALIMA] [float] NOT NULL,
	[D2_BASIMA] [float] NOT NULL,
	[D2_ALIIMA] [float] NOT NULL,
	[D2_VALFASE] [float] NOT NULL,
	[D2_BASFASE] [float] NOT NULL,
	[D2_ALIFASE] [float] NOT NULL,
	[D2_INDICE] [float] NOT NULL,
	[D2_CSOSN] [varchar](3) NOT NULL,
	[D2_ALQFECP] [float] NOT NULL,
	[D2_VALFECP] [float] NOT NULL,
	[D2_VFECPST] [float] NOT NULL,
 CONSTRAINT [SD2010_PK] PRIMARY KEY CLUSTERED 
(
	[R_E_C_N_O_] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SE1010]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SE1010](
	[E1_FILIAL] [varchar](2) NOT NULL,
	[E1_PREFIXO] [varchar](3) NOT NULL,
	[E1_NUM] [varchar](9) NOT NULL,
	[E1_PARCELA] [varchar](3) NOT NULL,
	[E1_TIPO] [varchar](3) NOT NULL,
	[E1_NATUREZ] [varchar](10) NOT NULL,
	[E1_PORTADO] [varchar](3) NOT NULL,
	[E1_AGEDEP] [varchar](5) NOT NULL,
	[E1_CLIENTE] [varchar](6) NOT NULL,
	[E1_LOJA] [varchar](2) NOT NULL,
	[E1_NOMCLI] [varchar](20) NOT NULL,
	[E1_EMISSAO] [varchar](8) NOT NULL,
	[E1_VENCTO] [varchar](8) NOT NULL,
	[E1_VENCREA] [varchar](8) NOT NULL,
	[E1_VALOR] [float] NOT NULL,
	[E1_IRRF] [float] NOT NULL,
	[E1_ISS] [float] NOT NULL,
	[E1_NUMBCO] [varchar](15) NOT NULL,
	[E1_X_NOSSO] [varchar](20) NOT NULL,
	[E1_INDICE] [varchar](3) NOT NULL,
	[E1_BAIXA] [varchar](8) NOT NULL,
	[E1_NUMBOR] [varchar](6) NOT NULL,
	[E1_DATABOR] [varchar](8) NOT NULL,
	[E1_EMIS1] [varchar](8) NOT NULL,
	[E1_X_FORMA] [varchar](3) NOT NULL,
	[E1_HIST] [varchar](25) NOT NULL,
	[E1_LA] [varchar](1) NOT NULL,
	[E1_LOTE] [varchar](8) NOT NULL,
	[E1_MOTIVO] [varchar](20) NOT NULL,
	[E1_MOVIMEN] [varchar](8) NOT NULL,
	[E1_OP] [varchar](13) NOT NULL,
	[E1_SITUACA] [varchar](1) NOT NULL,
	[E1_CONTRAT] [varchar](15) NOT NULL,
	[E1_SALDO] [float] NOT NULL,
	[E1_SUPERVI] [varchar](6) NOT NULL,
	[E1_VEND1] [varchar](6) NOT NULL,
	[E1_VEND2] [varchar](6) NOT NULL,
	[E1_VEND3] [varchar](6) NOT NULL,
	[E1_VEND4] [varchar](6) NOT NULL,
	[E1_VEND5] [varchar](6) NOT NULL,
	[E1_COMIS1] [float] NOT NULL,
	[E1_COMIS2] [float] NOT NULL,
	[E1_COMIS3] [float] NOT NULL,
	[E1_COMIS4] [float] NOT NULL,
	[E1_DESCONT] [float] NOT NULL,
	[E1_COMIS5] [float] NOT NULL,
	[E1_MULTA] [float] NOT NULL,
	[E1_JUROS] [float] NOT NULL,
	[E1_CORREC] [float] NOT NULL,
	[E1_VALLIQ] [float] NOT NULL,
	[E1_VENCORI] [varchar](8) NOT NULL,
	[E1_CONTA] [varchar](10) NOT NULL,
	[E1_VALJUR] [float] NOT NULL,
	[E1_PORCJUR] [float] NOT NULL,
	[E1_MOEDA] [float] NOT NULL,
	[E1_BASCOM1] [float] NOT NULL,
	[E1_BASCOM2] [float] NOT NULL,
	[E1_BASCOM3] [float] NOT NULL,
	[E1_BASCOM4] [float] NOT NULL,
	[E1_BASCOM5] [float] NOT NULL,
	[E1_OK] [varchar](2) NOT NULL,
	[E1_FATPREF] [varchar](3) NOT NULL,
	[E1_FATURA] [varchar](9) NOT NULL,
	[E1_PROJETO] [varchar](6) NOT NULL,
	[E1_CLASCON] [varchar](5) NOT NULL,
	[E1_VALCOM1] [float] NOT NULL,
	[E1_VALCOM2] [float] NOT NULL,
	[E1_VALCOM3] [float] NOT NULL,
	[E1_VALCOM4] [float] NOT NULL,
	[E1_VALCOM5] [float] NOT NULL,
	[E1_OCORREN] [varchar](2) NOT NULL,
	[E1_INSTR1] [varchar](2) NOT NULL,
	[E1_INSTR2] [varchar](2) NOT NULL,
	[E1_PEDIDO] [varchar](6) NOT NULL,
	[E1_DTVARIA] [varchar](8) NOT NULL,
	[E1_VARURV] [float] NOT NULL,
	[E1_NUMNOTA] [varchar](9) NOT NULL,
	[E1_SERIE] [varchar](3) NOT NULL,
	[E1_VLCRUZ] [float] NOT NULL,
	[E1_DTFATUR] [varchar](8) NOT NULL,
	[E1_IDENTEE] [varchar](6) NOT NULL,
	[E1_STATUS] [varchar](1) NOT NULL,
	[E1_ORIGEM] [varchar](8) NOT NULL,
	[E1_NUMCART] [varchar](19) NOT NULL,
	[E1_FLUXO] [varchar](1) NOT NULL,
	[E1_DESCFIN] [float] NOT NULL,
	[E1_DIADESC] [float] NOT NULL,
	[E1_TIPODES] [varchar](1) NOT NULL,
	[E1_CARTAO] [varchar](16) NOT NULL,
	[E1_CARTVAL] [varchar](8) NOT NULL,
	[E1_VLRREAL] [float] NOT NULL,
	[E1_CARTAUT] [varchar](6) NOT NULL,
	[E1_ADM] [varchar](3) NOT NULL,
	[E1_TRANSF] [varchar](15) NOT NULL,
	[E1_BCOCHQ] [varchar](3) NOT NULL,
	[E1_AGECHQ] [varchar](5) NOT NULL,
	[E1_ORDPAGO] [varchar](6) NOT NULL,
	[E1_CTACHQ] [varchar](10) NOT NULL,
	[E1_NUMLIQ] [varchar](6) NOT NULL,
	[E1__NUMLIQ] [varchar](6) NOT NULL,
	[E1_RECIBO] [varchar](6) NOT NULL,
	[E1_INSS] [float] NOT NULL,
	[E1_FILORIG] [varchar](2) NOT NULL,
	[E1_DTACRED] [varchar](8) NOT NULL,
	[E1_TIPOFAT] [varchar](3) NOT NULL,
	[E1_TIPOLIQ] [varchar](3) NOT NULL,
	[E1_FLAGFAT] [varchar](1) NOT NULL,
	[E1_CSLL] [float] NOT NULL,
	[E1_COFINS] [float] NOT NULL,
	[E1_PIS] [float] NOT NULL,
	[E1_MESBASE] [varchar](2) NOT NULL,
	[E1_ANOBASE] [varchar](4) NOT NULL,
	[E1_PLNUCOB] [varchar](12) NOT NULL,
	[E1_CODINT] [varchar](4) NOT NULL,
	[E1_CODEMP] [varchar](4) NOT NULL,
	[E1_MATRIC] [varchar](6) NOT NULL,
	[E1_TXMOEDA] [float] NOT NULL,
	[E1_ACRESC] [float] NOT NULL,
	[E1_X_ACRES] [float] NOT NULL,
	[E1_SDACRES] [float] NOT NULL,
	[E1_DECRESC] [float] NOT NULL,
	[E1_SDDECRE] [float] NOT NULL,
	[E1_MULTNAT] [varchar](1) NOT NULL,
	[E1_MSFIL] [varchar](2) NOT NULL,
	[E1_MSEMP] [varchar](2) NOT NULL,
	[E1_PROJPMS] [varchar](1) NOT NULL,
	[E1_DESDOBR] [varchar](1) NOT NULL,
	[E1_NRDOC] [varchar](50) NOT NULL,
	[E1_EMITCHQ] [varchar](40) NOT NULL,
	[E1_MODSPB] [varchar](1) NOT NULL,
	[E1_IDCNAB] [varchar](10) NOT NULL,
	[E1_PLCOEMP] [varchar](12) NOT NULL,
	[E1_PLTPCOE] [varchar](1) NOT NULL,
	[E1_CODCOR] [varchar](6) NOT NULL,
	[E1_PARCCSS] [varchar](3) NOT NULL,
	[E1_CODORCA] [varchar](8) NOT NULL,
	[E1_CODIMOV] [varchar](12) NOT NULL,
	[E1_FILDEB] [varchar](2) NOT NULL,
	[E1_NUMSOL] [varchar](6) NOT NULL,
	[E1_DATAEDI] [varchar](8) NOT NULL,
	[E1_NUMRA] [varchar](15) NOT NULL,
	[E1_SERREC] [varchar](3) NOT NULL,
	[E1_INSCRIC] [varchar](10) NOT NULL,
	[E1_CODBAR] [varchar](44) NOT NULL,
	[E1_CODDIG] [varchar](48) NOT NULL,
	[E1_CHQDEV] [varchar](1) NOT NULL,
	[E1_VLBOLSA] [float] NOT NULL,
	[E1_LIDESCF] [varchar](8) NOT NULL,
	[E1_NUMCRD] [varchar](10) NOT NULL,
	[E1_VLFIES] [float] NOT NULL,
	[E1_DEBITO] [varchar](20) NOT NULL,
	[E1_CCD] [varchar](9) NOT NULL,
	[E1_ITEMD] [varchar](11) NOT NULL,
	[E1_CLVLDB] [varchar](20) NOT NULL,
	[E1_CREDIT] [varchar](20) NOT NULL,
	[E1_CCC] [varchar](9) NOT NULL,
	[E1_ITEMC] [varchar](11) NOT NULL,
	[E1_CLVLCR] [varchar](20) NOT NULL,
	[E1_DESCON1] [float] NOT NULL,
	[E1_DESCON2] [float] NOT NULL,
	[E1_DTDESC3] [varchar](8) NOT NULL,
	[E1_DTDESC1] [varchar](8) NOT NULL,
	[E1_DTDESC2] [varchar](8) NOT NULL,
	[E1_VLMULTA] [float] NOT NULL,
	[E1_DESCON3] [float] NOT NULL,
	[E1_MOTNEG] [varchar](3) NOT NULL,
	[E1_SABTPIS] [float] NOT NULL,
	[E1_SABTCOF] [float] NOT NULL,
	[E1_SABTCSL] [float] NOT NULL,
	[E1_FORNISS] [varchar](6) NOT NULL,
	[E1_PARTOT] [varchar](4) NOT NULL,
	[E1_SITFAT] [varchar](1) NOT NULL,
	[E1_PARCIRF] [varchar](3) NOT NULL,
	[E1_BASEPIS] [float] NOT NULL,
	[E1_BASECOF] [float] NOT NULL,
	[E1_BASECSL] [float] NOT NULL,
	[E1_VRETISS] [float] NOT NULL,
	[E1_SCORGP] [varchar](1) NOT NULL,
	[E1_FRETISS] [varchar](1) NOT NULL,
	[E1_TXMDCOR] [float] NOT NULL,
	[E1_SATBIRF] [float] NOT NULL,
	[E1_TIPREG] [varchar](2) NOT NULL,
	[E1_CONEMP] [varchar](12) NOT NULL,
	[E1_VERCON] [varchar](3) NOT NULL,
	[E1_SUBCON] [varchar](9) NOT NULL,
	[E1_VERSUB] [varchar](3) NOT NULL,
	[E1_PLLOTE] [varchar](10) NOT NULL,
	[E1_PLOPELT] [varchar](4) NOT NULL,
	[E1_CODRDA] [varchar](6) NOT NULL,
	[E1_FORMREC] [varchar](2) NOT NULL,
	[E1_BCOCLI] [varchar](3) NOT NULL,
	[E1_AGECLI] [varchar](5) NOT NULL,
	[E1_CTACLI] [varchar](10) NOT NULL,
	[E1_PARCFET] [varchar](3) NOT NULL,
	[E1_FETHAB] [float] NOT NULL,
	[E1_MDCRON] [varchar](6) NOT NULL,
	[E1_MDCONTR] [varchar](15) NOT NULL,
	[E1_MEDNUME] [varchar](6) NOT NULL,
	[E1_MDPLANI] [varchar](6) NOT NULL,
	[E1_MDPARCE] [varchar](3) NOT NULL,
	[E1_MDREVIS] [varchar](3) NOT NULL,
	[E1_NUMMOV] [varchar](2) NOT NULL,
	[E1_NODIA] [varchar](10) NOT NULL,
	[E1_DOCTEF] [varchar](20) NOT NULL,
	[E1_NUMCON] [varchar](20) NOT NULL,
	[E1_RETCNTR] [float] NOT NULL,
	[E1_MDDESC] [float] NOT NULL,
	[E1_MDBONI] [float] NOT NULL,
	[E1_MDMULT] [float] NOT NULL,
	[E1_VRETIRF] [float] NOT NULL,
	[E1_DIACTB] [varchar](2) NOT NULL,
	[E1_APLVLMN] [varchar](1) NOT NULL,
	[E1_SABTIRF] [float] NOT NULL,
	[E1_NFELETR] [varchar](20) NOT NULL,
	[E1_X_ADMFI] [varchar](3) NOT NULL,
	[E1_X_CLIOR] [varchar](6) NOT NULL,
	[E1_X_LOJOR] [varchar](2) NOT NULL,
	[E1__SERIE] [varchar](1) NOT NULL,
	[E1_X_NUMAG] [varchar](6) NOT NULL,
	[E1_X_TIPAG] [varchar](1) NOT NULL,
	[E1_X_DATAG] [varchar](8) NOT NULL,
	[E1_X_HORAG] [varchar](8) NOT NULL,
	[E1_X_USRAG] [varchar](20) NOT NULL,
	[E1_X_OR1AG] [varchar](69) NOT NULL,
	[E1_X_OR2AG] [varchar](69) NOT NULL,
	[E1_X_TARIF] [float] NOT NULL,
	[E1_X_IDCOB] [varchar](10) NOT NULL,
	[D_E_L_E_T_] [varchar](1) NOT NULL,
	[R_E_C_N_O_] [int] NOT NULL,
	[R_E_C_D_E_L_] [int] NOT NULL,
	[E1_X_PEDG] [varchar](6) NOT NULL,
	[E1_X_VENC] [varchar](8) NOT NULL,
	[E1_X_AVIST] [varchar](1) NOT NULL,
	[E1_X_ENTRA] [varchar](1) NOT NULL,
	[E1_X_LOG] [varchar](40) NOT NULL,
	[E1_X_LOGAG] [varchar](40) NOT NULL,
	[E1_X_VENDL] [varchar](6) NOT NULL,
	[E1_X_PEDSE] [varchar](1) NOT NULL,
	[E1_X_VEND1] [varchar](6) NOT NULL,
	[E1__NUMFAT] [varchar](9) NOT NULL,
	[E1_X_SALAG] [float] NOT NULL,
	[E1_X_ACRAG] [float] NOT NULL,
	[E1_X_BCOM1] [float] NOT NULL,
	[E1_X_PCOM1] [float] NOT NULL,
	[E1_X_DESCF] [float] NOT NULL,
	[E1_X_TARPG] [varchar](1) NOT NULL,
	[E1_X_NCART] [varchar](19) NOT NULL,
	[E1_X_NBOL] [varchar](20) NOT NULL,
	[E1_X_DTGB] [varchar](8) NOT NULL,
	[E1_X_MSG01] [varchar](69) NOT NULL,
	[E1_X_UPARC] [varchar](3) NOT NULL,
	[E1_VLMINIS] [varchar](1) NOT NULL,
	[E1_CODISS] [varchar](6) NOT NULL,
	[E1_BASEISS] [float] NOT NULL,
	[E1_FACS] [float] NOT NULL,
	[E1_PARCFAC] [varchar](3) NOT NULL,
	[E1_FABOV] [float] NOT NULL,
	[E1_PARCFAB] [varchar](3) NOT NULL,
	[E1_BASEINS] [float] NOT NULL,
	[E1_BASEIRF] [float] NOT NULL,
	[E1_SEQBX] [varchar](2) NOT NULL,
	[E1_TITPAI] [varchar](50) NOT NULL,
	[E1_X_TARBE] [float] NOT NULL,
	[E1_X_JURID] [varchar](1) NOT NULL,
	[E1_LTCXA] [varchar](10) NOT NULL,
	[E1_NOPER] [float] NOT NULL,
	[E1_X_AGLPD] [varchar](6) NOT NULL,
	[E1_CODIRRF] [varchar](4) NOT NULL,
	[E1_NUMPRO] [varchar](10) NOT NULL,
	[E1_INDPRO] [varchar](1) NOT NULL,
	[E1_TPDESC] [varchar](1) NOT NULL,
	[E1_PREFORI] [varchar](3) NOT NULL,
	[E1_JURFAT] [varchar](50) NOT NULL,
	[E1_RELATO] [varchar](1) NOT NULL,
	[E1_MULTDIA] [float] NOT NULL,
	[E1_TURMA] [varchar](20) NOT NULL,
	[E1_IDLAN] [float] NOT NULL,
	[E1_NSUTEF] [varchar](9) NOT NULL,
	[E1_IDAPLIC] [float] NOT NULL,
	[E1_PROCEL] [float] NOT NULL,
	[E1_SERVICO] [varchar](10) NOT NULL,
	[E1_IDBOLET] [float] NOT NULL,
	[E1_VLBOLP] [float] NOT NULL,
	[E1_NUMINSC] [float] NOT NULL,
	[E1_TPDP] [float] NOT NULL,
	[E1_PARTPDP] [varchar](1) NOT NULL,
	[E1_X_EMPCB] [varchar](1) NOT NULL,
	[E1_IDMOV] [varchar](10) NOT NULL,
	[E1_PRINSS] [float] NOT NULL,
	[E1_RATFIN] [varchar](1) NOT NULL,
	[E1_PRISS] [float] NOT NULL,
	[E1_PRODUTO] [varchar](15) NOT NULL,
	[E1_PERLET] [varchar](4) NOT NULL,
	[E1_CHAVENF] [varchar](12) NOT NULL,
	[E1_X_SERAS] [varchar](1) NOT NULL,
	[E1_FAMAD] [float] NOT NULL,
	[E1_PARCFAM] [varchar](1) NOT NULL,
	[E1_FMPEQ] [float] NOT NULL,
	[E1_PARCFMP] [varchar](1) NOT NULL,
	[E1_FUNDESA] [float] NOT NULL,
	[E1_IMAMT] [float] NOT NULL,
	[E1_FASEMT] [float] NOT NULL,
	[E1_PARFUND] [varchar](1) NOT NULL,
	[E1_PARIMA] [varchar](1) NOT NULL,
	[E1_PARFASE] [varchar](1) NOT NULL,
	[E1_CODRET] [varchar](4) NOT NULL,
	[E1_CTRBCO] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SF1010]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SF1010](
	[F1_FILIAL] [varchar](2) NOT NULL,
	[F1_DOC] [varchar](9) NOT NULL,
	[F1_SERIE] [varchar](3) NOT NULL,
	[F1_FORNECE] [varchar](6) NOT NULL,
	[F1_LOJA] [varchar](2) NOT NULL,
	[F1_COND] [varchar](3) NOT NULL,
	[F1_DUPL] [varchar](9) NOT NULL,
	[F1_EMISSAO] [varchar](8) NOT NULL,
	[F1_EST] [varchar](2) NOT NULL,
	[F1_FRETE] [float] NOT NULL,
	[F1_DESPESA] [float] NOT NULL,
	[F1_BASEICM] [float] NOT NULL,
	[F1_VALICM] [float] NOT NULL,
	[F1_BASEIPI] [float] NOT NULL,
	[F1_VALIPI] [float] NOT NULL,
	[F1_VALMERC] [float] NOT NULL,
	[F1_VALBRUT] [float] NOT NULL,
	[F1_TIPO] [varchar](1) NOT NULL,
	[F1_DESCONT] [float] NOT NULL,
	[F1_DTDIGIT] [varchar](8) NOT NULL,
	[F1_CPROVA] [varchar](14) NOT NULL,
	[F1_BRICMS] [float] NOT NULL,
	[F1_ICMSRET] [float] NOT NULL,
	[F1_BASEFD] [float] NOT NULL,
	[F1_DTLANC] [varchar](8) NOT NULL,
	[F1_OK] [varchar](2) NOT NULL,
	[F1_ORIGLAN] [varchar](2) NOT NULL,
	[F1_TX] [varchar](1) NOT NULL,
	[F1_CONTSOC] [float] NOT NULL,
	[F1_IRRF] [float] NOT NULL,
	[F1_FORMUL] [varchar](1) NOT NULL,
	[F1_NFORIG] [varchar](9) NOT NULL,
	[F1_SERORIG] [varchar](3) NOT NULL,
	[F1_ESPECIE] [varchar](5) NOT NULL,
	[F1_IMPORT] [varchar](1) NOT NULL,
	[F1_II] [float] NOT NULL,
	[F1_REMITO] [varchar](9) NOT NULL,
	[F1_BASIMP2] [float] NOT NULL,
	[F1_BASIMP3] [float] NOT NULL,
	[F1_BASIMP4] [float] NOT NULL,
	[F1_BASIMP5] [float] NOT NULL,
	[F1_BASIMP6] [float] NOT NULL,
	[F1_VALIMP1] [float] NOT NULL,
	[F1_VALIMP2] [float] NOT NULL,
	[F1_VALIMP3] [float] NOT NULL,
	[F1_VALIMP4] [float] NOT NULL,
	[F1_VALIMP5] [float] NOT NULL,
	[F1_VALIMP6] [float] NOT NULL,
	[F1_ORDPAGO] [varchar](6) NOT NULL,
	[F1_HORA] [varchar](8) NOT NULL,
	[F1_INSS] [float] NOT NULL,
	[F1_ISS] [float] NOT NULL,
	[F1_BASIMP1] [float] NOT NULL,
	[F1_HAWB] [varchar](17) NOT NULL,
	[F1_TIPO_NF] [varchar](1) NOT NULL,
	[F1_IPI] [float] NOT NULL,
	[F1_ICMS] [float] NOT NULL,
	[F1_PESOL] [float] NOT NULL,
	[F1_FOB_R] [float] NOT NULL,
	[F1_SEGURO] [float] NOT NULL,
	[F1_CIF] [float] NOT NULL,
	[F1_MOEDA] [float] NOT NULL,
	[F1_PREFIXO] [varchar](3) NOT NULL,
	[F1_STATUS] [varchar](1) NOT NULL,
	[F1_VALEMB] [float] NOT NULL,
	[F1_RECBMTO] [varchar](8) NOT NULL,
	[F1_CTR_NFC] [varchar](12) NOT NULL,
	[F1_APROV] [varchar](6) NOT NULL,
	[F1_TXMOEDA] [float] NOT NULL,
	[F1_PEDVEND] [varchar](6) NOT NULL,
	[F1_TIPODOC] [varchar](2) NOT NULL,
	[F1_TIPOREM] [varchar](1) NOT NULL,
	[F1_GNR] [varchar](6) NOT NULL,
	[F1_VALPIS] [float] NOT NULL,
	[F1_VALCOFI] [float] NOT NULL,
	[F1_VALCSLL] [float] NOT NULL,
	[F1_BASEPS3] [float] NOT NULL,
	[F1_VALPS3] [float] NOT NULL,
	[F1_BASECF3] [float] NOT NULL,
	[F1_VALCF3] [float] NOT NULL,
	[F1_NFELETR] [varchar](20) NOT NULL,
	[F1_EMINFE] [varchar](8) NOT NULL,
	[F1_HORNFE] [varchar](8) NOT NULL,
	[F1_CODNFE] [varchar](50) NOT NULL,
	[F1_CREDNFE] [float] NOT NULL,
	[F1_VNAGREG] [float] NOT NULL,
	[F1_NUMRPS] [varchar](12) NOT NULL,
	[F1_VALIRF] [float] NOT NULL,
	[F1_NUMMOV] [varchar](2) NOT NULL,
	[F1_CHVNFE] [varchar](44) NOT NULL,
	[F1_RECISS] [varchar](1) NOT NULL,
	[F1_FILORIG] [varchar](2) NOT NULL,
	[F1_NODIA] [varchar](10) NOT NULL,
	[F1_ESTCRED] [float] NOT NULL,
	[F1_DIACTB] [varchar](2) NOT NULL,
	[F1_NUMRA] [varchar](6) NOT NULL,
	[F1_BASEINS] [float] NOT NULL,
	[F1_VALFDS] [float] NOT NULL,
	[F1_TRANSP] [varchar](6) NOT NULL,
	[F1_PLIQUI] [float] NOT NULL,
	[F1_PBRUTO] [float] NOT NULL,
	[F1_ESPECI1] [varchar](10) NOT NULL,
	[F1_VOLUME1] [float] NOT NULL,
	[F1_ESPECI2] [varchar](10) NOT NULL,
	[F1_VOLUME2] [float] NOT NULL,
	[F1_ESPECI3] [varchar](10) NOT NULL,
	[F1_VOLUME3] [float] NOT NULL,
	[F1_ESPECI4] [varchar](10) NOT NULL,
	[F1_VOLUME4] [float] NOT NULL,
	[D_E_L_E_T_] [varchar](1) NOT NULL,
	[R_E_C_N_O_] [int] NOT NULL,
	[R_E_C_D_E_L_] [int] NOT NULL,
	[F1_PLACA] [varchar](8) NOT NULL,
	[F1_DOCFOL] [varchar](9) NOT NULL,
	[F1_VERBAFO] [varchar](9) NOT NULL,
	[F1_TPNFEXP] [varchar](1) NOT NULL,
	[F1_X_BLOQ] [varchar](1) NOT NULL,
	[F1__ICMRET] [float] NOT NULL,
	[F1_TPFRETE] [varchar](1) NOT NULL,
	[F1_FIMP] [varchar](1) NOT NULL,
	[F1_VALFAB] [float] NOT NULL,
	[F1_VALFAC] [float] NOT NULL,
	[F1_VALFET] [float] NOT NULL,
	[F1_BASEFUN] [float] NOT NULL,
	[F1_VALPEDG] [float] NOT NULL,
	[F1_FORRET] [varchar](6) NOT NULL,
	[F1_LOJARET] [varchar](2) NOT NULL,
	[F1_RECOPI] [varchar](1) NOT NULL,
	[F1_VALINA] [float] NOT NULL,
	[F1_BASEINA] [float] NOT NULL,
	[F1_BASPIS] [float] NOT NULL,
	[F1_BASCOFI] [float] NOT NULL,
	[F1_BASCSLL] [float] NOT NULL,
	[F1_TPCTE] [varchar](1) NOT NULL,
	[F1_VLSENAR] [float] NOT NULL,
	[F1_NUMAIDF] [varchar](7) NOT NULL,
	[F1_ANOAIDF] [varchar](4) NOT NULL,
	[F1_EVENFLG] [varchar](1) NOT NULL,
	[F1_IDCCE] [varchar](54) NOT NULL,
	[F1_FLAGRGS] [varchar](4) NOT NULL,
	[F1_IDRGS] [varchar](54) NOT NULL,
	[F1_CODRGS] [varchar](1) NOT NULL,
	[F1_DAUTNFE] [varchar](8) NOT NULL,
	[F1_HAUTNFE] [varchar](5) NOT NULL,
	[F1_MENNOTA] [varchar](60) NOT NULL,
	[F1_MENPAD] [varchar](3) NOT NULL,
	[F1_FORENT] [varchar](6) NOT NULL,
	[F1_LOJAENT] [varchar](2) NOT NULL,
	[F1_STATCON] [varchar](1) NOT NULL,
	[F1_MSIDENT] [varchar](10) NOT NULL,
	[F1_QTDCONF] [float] NOT NULL,
	[F1_NUMTRIB] [varchar](9) NOT NULL,
	[F1_INCISS] [varchar](5) NOT NULL,
	[F1_ESTPRES] [varchar](2) NOT NULL,
	[F1_IDRECOP] [varchar](6) NOT NULL,
	[F1_VLCIDE] [float] NOT NULL,
	[F1_BASECID] [float] NOT NULL,
	[F1_VLCPM] [float] NOT NULL,
	[F1_BASECPM] [float] NOT NULL,
	[F1_VALFMD] [float] NOT NULL,
	[F1_LOJAORI] [varchar](2) NOT NULL,
	[F1_CLIORI] [varchar](6) NOT NULL,
	[F1_IDSED] [varchar](20) NOT NULL,
	[F1_IDSA2] [varchar](20) NOT NULL,
	[F1_IDSA1] [varchar](20) NOT NULL,
	[F1_DTCPISS] [varchar](8) NOT NULL,
	[F1_VALFMP] [float] NOT NULL,
	[F1_BASEFMP] [float] NOT NULL,
	[F1_CLIDEST] [varchar](6) NOT NULL,
	[F1_LOJDEST] [varchar](2) NOT NULL,
	[F1_ESTDES] [varchar](2) NOT NULL,
	[F1_VALFUND] [float] NOT NULL,
	[F1_VALIMA] [float] NOT NULL,
	[F1_VALFASE] [float] NOT NULL,
 CONSTRAINT [SF1010_PK] PRIMARY KEY CLUSTERED 
(
	[R_E_C_N_O_] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SF2010]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SF2010](
	[F2_DOC] [varchar](9) NOT NULL,
	[F2_SERIE] [varchar](3) NOT NULL,
	[F2_CLIENTE] [varchar](6) NOT NULL,
	[F2_LOJA] [varchar](2) NOT NULL,
	[F2_COND] [varchar](3) NOT NULL,
	[F2_DUPL] [varchar](9) NOT NULL,
	[F2_EMISSAO] [varchar](8) NOT NULL,
	[F2_EST] [varchar](2) NOT NULL,
	[F2_FRETE] [float] NOT NULL,
	[F2_SEGURO] [float] NOT NULL,
	[F2_ICMFRET] [float] NOT NULL,
	[F2_TIPOCLI] [varchar](1) NOT NULL,
	[F2_VALBRUT] [float] NOT NULL,
	[F2_VALICM] [float] NOT NULL,
	[F2_BASEICM] [float] NOT NULL,
	[F2_VALIPI] [float] NOT NULL,
	[F2_BASEIPI] [float] NOT NULL,
	[F2_VALMERC] [float] NOT NULL,
	[F2_NFORI] [varchar](9) NOT NULL,
	[F2_DESCONT] [float] NOT NULL,
	[F2_SERIORI] [varchar](3) NOT NULL,
	[F2_TIPO] [varchar](1) NOT NULL,
	[F2_ESPECI1] [varchar](10) NOT NULL,
	[F2_ESPECI2] [varchar](10) NOT NULL,
	[F2_ESPECI3] [varchar](10) NOT NULL,
	[F2_ESPECI4] [varchar](10) NOT NULL,
	[F2_VOLUME1] [float] NOT NULL,
	[F2_VOLUME2] [float] NOT NULL,
	[F2_VOLUME3] [float] NOT NULL,
	[F2_VOLUME4] [float] NOT NULL,
	[F2_ICMSRET] [float] NOT NULL,
	[F2_PLIQUI] [float] NOT NULL,
	[F2_PBRUTO] [float] NOT NULL,
	[F2_TRANSP] [varchar](6) NOT NULL,
	[F2_REDESP] [varchar](6) NOT NULL,
	[F2_VEND1] [varchar](6) NOT NULL,
	[F2_VEND2] [varchar](6) NOT NULL,
	[F2_VEND3] [varchar](6) NOT NULL,
	[F2_VEND4] [varchar](6) NOT NULL,
	[F2_VEND5] [varchar](6) NOT NULL,
	[F2_OK] [varchar](4) NOT NULL,
	[F2_FIMP] [varchar](1) NOT NULL,
	[F2_DTLANC] [varchar](8) NOT NULL,
	[F2_DTREAJ] [varchar](8) NOT NULL,
	[F2_REAJUST] [varchar](3) NOT NULL,
	[F2_DTBASE0] [varchar](8) NOT NULL,
	[F2_FATORB0] [float] NOT NULL,
	[F2_DTBASE1] [varchar](8) NOT NULL,
	[F2_FATORB1] [float] NOT NULL,
	[F2_VARIAC] [float] NOT NULL,
	[F2_FILIAL] [varchar](2) NOT NULL,
	[F2_BASEISS] [float] NOT NULL,
	[F2_VALISS] [float] NOT NULL,
	[F2_VALFAT] [float] NOT NULL,
	[F2_CONTSOC] [float] NOT NULL,
	[F2_BRICMS] [float] NOT NULL,
	[F2_FRETAUT] [float] NOT NULL,
	[F2_ICMAUTO] [float] NOT NULL,
	[F2_DESPESA] [float] NOT NULL,
	[F2_NEXTSER] [varchar](3) NOT NULL,
	[F2_NEXTDOC] [varchar](9) NOT NULL,
	[F2_ESPECIE] [varchar](5) NOT NULL,
	[F2_PDV] [varchar](10) NOT NULL,
	[F2_MAPA] [varchar](10) NOT NULL,
	[F2_ECF] [varchar](1) NOT NULL,
	[F2_PREFIXO] [varchar](3) NOT NULL,
	[F2_BASIMP1] [float] NOT NULL,
	[F2_BASIMP2] [float] NOT NULL,
	[F2_BASIMP3] [float] NOT NULL,
	[F2_BASIMP4] [float] NOT NULL,
	[F2_BASIMP5] [float] NOT NULL,
	[F2_BASIMP6] [float] NOT NULL,
	[F2_VALIMP1] [float] NOT NULL,
	[F2_VALIMP2] [float] NOT NULL,
	[F2_VALIMP3] [float] NOT NULL,
	[F2_VALIMP4] [float] NOT NULL,
	[F2_VALIMP5] [float] NOT NULL,
	[F2_VALIMP6] [float] NOT NULL,
	[F2_ORDPAGO] [varchar](6) NOT NULL,
	[F2_NFCUPOM] [varchar](12) NOT NULL,
	[F2_VALINSS] [float] NOT NULL,
	[F2_HORA] [varchar](5) NOT NULL,
	[F2_MOEDA] [float] NOT NULL,
	[F2_REGIAO] [varchar](3) NOT NULL,
	[F2_VALCSLL] [float] NOT NULL,
	[F2_VALCOFI] [float] NOT NULL,
	[F2_VALPIS] [float] NOT NULL,
	[F2_LOTE] [varchar](1) NOT NULL,
	[F2_TXMOEDA] [float] NOT NULL,
	[F2_VALIRRF] [float] NOT NULL,
	[F2_CARGA] [varchar](6) NOT NULL,
	[F2_RECFAUT] [varchar](1) NOT NULL,
	[F2_SEQCAR] [varchar](2) NOT NULL,
	[F2_BASEINS] [float] NOT NULL,
	[F2_PEDPEND] [varchar](6) NOT NULL,
	[F2_DESCCAB] [float] NOT NULL,
	[F2_DTENTR] [varchar](8) NOT NULL,
	[F2_FORMUL] [varchar](1) NOT NULL,
	[F2_TIPODOC] [varchar](2) NOT NULL,
	[F2_NFEACRS] [varchar](9) NOT NULL,
	[F2_TIPOREM] [varchar](1) NOT NULL,
	[F2_SEQENT] [varchar](6) NOT NULL,
	[F2_ICMSDIF] [float] NOT NULL,
	[F2_VALACRS] [float] NOT NULL,
	[F2_RECISS] [varchar](1) NOT NULL,
	[F2_HAWB] [varchar](17) NOT NULL,
	[F2_BASEPS3] [float] NOT NULL,
	[F2_VALPS3] [float] NOT NULL,
	[F2_BASECF3] [float] NOT NULL,
	[F2_VALCF3] [float] NOT NULL,
	[F2_VEICUL1] [varchar](8) NOT NULL,
	[F2_VEICUL2] [varchar](8) NOT NULL,
	[F2_NFELETR] [varchar](20) NOT NULL,
	[F2_EMINFE] [varchar](8) NOT NULL,
	[F2_HORNFE] [varchar](8) NOT NULL,
	[F2_CODNFE] [varchar](50) NOT NULL,
	[F2_CREDNFE] [float] NOT NULL,
	[F2_TIPORET] [varchar](1) NOT NULL,
	[F2_VALTST] [float] NOT NULL,
	[F2_ESTCRED] [float] NOT NULL,
	[F2_CHVNFE] [varchar](44) NOT NULL,
	[F2_DIACTB] [varchar](2) NOT NULL,
	[F2_NODIA] [varchar](10) NOT NULL,
	[F2_BASEIRR] [float] NOT NULL,
	[F2_FILDEST] [varchar](2) NOT NULL,
	[F2_DTDIGIT] [varchar](8) NOT NULL,
	[F2_VEICUL3] [varchar](8) NOT NULL,
	[F2_VLR_FRT] [float] NOT NULL,
	[F2_BASETST] [float] NOT NULL,
	[F2_VALFDS] [float] NOT NULL,
	[F2_CLIENT] [varchar](6) NOT NULL,
	[F2_LOJENT] [varchar](2) NOT NULL,
	[F2_FLAGDEV] [varchar](1) NOT NULL,
	[F2_TPNFEXP] [varchar](1) NOT NULL,
	[D_E_L_E_T_] [varchar](1) NOT NULL,
	[R_E_C_N_O_] [int] NOT NULL,
	[R_E_C_D_E_L_] [int] NOT NULL,
	[F2_X_ATEND] [float] NOT NULL,
	[F2_X_TPFRE] [varchar](1) NOT NULL,
	[F2_X_FORMA] [varchar](3) NOT NULL,
	[F2_X_MENNF] [varchar](60) NOT NULL,
	[F2_X_NF] [varchar](12) NOT NULL,
	[F2_X_AGRUP] [varchar](6) NOT NULL,
	[F2_X_PLACA] [varchar](7) NOT NULL,
	[F2_X_SITUA] [varchar](3) NOT NULL,
	[F2_X_DTFAT] [varchar](8) NOT NULL,
	[F2_X_HRFAT] [varchar](8) NOT NULL,
	[F2_X_USFAT] [varchar](20) NOT NULL,
	[F2_X_DTEXC] [varchar](8) NOT NULL,
	[F2_X_HREXC] [varchar](8) NOT NULL,
	[F2_X_USEXC] [varchar](20) NOT NULL,
	[F2__SERIE] [varchar](1) NOT NULL,
	[F2_X_ADMFI] [varchar](3) NOT NULL,
	[F2_X_CLICC] [varchar](6) NOT NULL,
	[F2_X_LOJCC] [varchar](2) NOT NULL,
	[F2_X_VEND2] [varchar](6) NOT NULL,
	[F2_X_VEND3] [varchar](6) NOT NULL,
	[F2_X_PEDSE] [varchar](1) NOT NULL,
	[F2_X_EXPDP] [varchar](1) NOT NULL,
	[F2_X_STDEL] [varchar](1) NOT NULL,
	[F2_X_CODEN] [varchar](6) NOT NULL,
	[F2_X_UGERO] [varchar](30) NOT NULL,
	[F2_X_DGERO] [varchar](30) NOT NULL,
	[F2_X_HGERO] [varchar](30) NOT NULL,
	[F2_X_UIMRO] [varchar](30) NOT NULL,
	[F2_X_DIMRO] [varchar](30) NOT NULL,
	[F2_X_HIMRO] [varchar](30) NOT NULL,
	[F2_X_UEXRO] [varchar](30) NOT NULL,
	[F2_X_DEXRO] [varchar](30) NOT NULL,
	[F2_X_HEXRO] [varchar](30) NOT NULL,
	[F2_X_UFIRO] [varchar](30) NOT NULL,
	[F2_X_DFIRO] [varchar](30) NOT NULL,
	[F2_X_HFIRO] [varchar](30) NOT NULL,
	[F2_X_ORDRO] [varchar](3) NOT NULL,
	[F2_NFICMST] [varchar](12) NOT NULL,
	[F2_TPFRETE] [varchar](1) NOT NULL,
	[F2_VALFAB] [float] NOT NULL,
	[F2_VALFAC] [float] NOT NULL,
	[F2_VALFET] [float] NOT NULL,
	[F2_X_NCART] [varchar](19) NOT NULL,
	[F2_X_FLGIM] [varchar](1) NOT NULL,
	[F2_X_IMPBO] [varchar](1) NOT NULL,
	[F2_BASEFUN] [float] NOT NULL,
	[F2_NFSUBST] [varchar](9) NOT NULL,
	[F2_SERSUBS] [varchar](3) NOT NULL,
	[F2_VLSENAR] [float] NOT NULL,
	[F2_NTFECP] [varchar](12) NOT NULL,
	[F2_RECOPI] [varchar](1) NOT NULL,
	[F2_VALINA] [float] NOT NULL,
	[F2_BASEINA] [float] NOT NULL,
	[F2_BASPIS] [float] NOT NULL,
	[F2_BASCOFI] [float] NOT NULL,
	[F2_BASCSLL] [float] NOT NULL,
	[F2_DESCZFR] [float] NOT NULL,
	[F2_DTTXREF] [varchar](8) NOT NULL,
	[F2_TXREF] [float] NOT NULL,
	[F2_X_NUMRO] [varchar](10) NOT NULL,
	[F2_CLEOK] [varchar](4) NOT NULL,
	[F2_EVENFLG] [varchar](1) NOT NULL,
	[F2_CHVCLE] [varchar](14) NOT NULL,
	[F2_IDCCE] [varchar](54) NOT NULL,
	[F2_IDCLE] [varchar](12) NOT NULL,
	[F2_VREINT] [float] NOT NULL,
	[F2_BSREIN] [float] NOT NULL,
	[F2_MENNOTA] [varchar](60) NOT NULL,
	[F2_FLAGRGS] [varchar](4) NOT NULL,
	[F2_IDRGS] [varchar](54) NOT NULL,
	[F2_CODRGS] [varchar](1) NOT NULL,
	[F2_DAUTNFE] [varchar](8) NOT NULL,
	[F2_HAUTNFE] [varchar](5) NOT NULL,
	[F2_ORDSEP] [varchar](6) NOT NULL,
	[F2_CGCCLI] [varchar](16) NOT NULL,
	[F2_REFTAXA] [float] NOT NULL,
	[F2_REFMOED] [float] NOT NULL,
	[F2_PREFORI] [varchar](3) NOT NULL,
	[F2_TOTIMP] [float] NOT NULL,
	[F2_TIPIMP] [varchar](1) NOT NULL,
	[F2_IDRECOP] [varchar](6) NOT NULL,
	[F2_TOTFED] [float] NOT NULL,
	[F2_TOTEST] [float] NOT NULL,
	[F2_TOTMUN] [float] NOT NULL,
	[F2_VLCPM] [float] NOT NULL,
	[F2_BASECPM] [float] NOT NULL,
	[F2_VALFMP] [float] NOT NULL,
	[F2_BASEFMP] [float] NOT NULL,
	[F2_VALFMD] [float] NOT NULL,
	[F2_FORMDES] [varchar](1) NOT NULL,
	[F2_NUMORC] [varchar](6) NOT NULL,
	[F2_IDSA1] [varchar](20) NOT NULL,
	[F2_IDSA2] [varchar](20) NOT NULL,
	[F2_IDSED] [varchar](20) NOT NULL,
	[F2_LOJADES] [varchar](2) NOT NULL,
	[F2_FORDES] [varchar](6) NOT NULL,
	[F2_GNRFECP] [varchar](12) NOT NULL,
	[F2_GNRDIF] [varchar](12) NOT NULL,
	[F2_DTESERV] [varchar](8) NOT NULL,
	[F2_VALFUND] [float] NOT NULL,
	[F2_VALIMA] [float] NOT NULL,
	[F2_VALFASE] [float] NOT NULL,
 CONSTRAINT [SF2010_PK] PRIMARY KEY CLUSTERED 
(
	[R_E_C_N_O_] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SF4010]    Script Date: 2017-12-14 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SF4010](
	[F4_FILIAL] [varchar](2) NOT NULL,
	[F4_CODIGO] [varchar](3) NOT NULL,
	[F4_TIPO] [varchar](1) NOT NULL,
	[F4_ICM] [varchar](1) NOT NULL,
	[F4_IPI] [varchar](1) NOT NULL,
	[F4_CREDICM] [varchar](1) NOT NULL,
	[F4_CREDIPI] [varchar](1) NOT NULL,
	[F4_DUPLIC] [varchar](1) NOT NULL,
	[F4_ESTOQUE] [varchar](1) NOT NULL,
	[F4_CF] [varchar](5) NOT NULL,
	[F4_TEXTO] [varchar](20) NOT NULL,
	[F4_CFEXT] [varchar](2) NOT NULL,
	[F4_BASEICM] [float] NOT NULL,
	[F4_BASEIPI] [float] NOT NULL,
	[F4_PODER3] [varchar](1) NOT NULL,
	[F4_LFICM] [varchar](1) NOT NULL,
	[F4_LFIPI] [varchar](1) NOT NULL,
	[F4_DESTACA] [varchar](1) NOT NULL,
	[F4_INCIDE] [varchar](1) NOT NULL,
	[F4_COMPL] [varchar](1) NOT NULL,
	[F4_IPIFRET] [varchar](1) NOT NULL,
	[F4_ISS] [varchar](1) NOT NULL,
	[F4_LFISS] [varchar](1) NOT NULL,
	[F4_NRLIVRO] [varchar](1) NOT NULL,
	[F4_UPRC] [varchar](1) NOT NULL,
	[F4_CONSUMO] [varchar](1) NOT NULL,
	[F4_FORMULA] [varchar](3) NOT NULL,
	[F4_AGREG] [varchar](1) NOT NULL,
	[F4_INCSOL] [varchar](1) NOT NULL,
	[F4_CIAP] [varchar](1) NOT NULL,
	[F4_DESPIPI] [varchar](1) NOT NULL,
	[F4_LIVRO] [varchar](64) NOT NULL,
	[F4_ATUTEC] [varchar](1) NOT NULL,
	[F4_ATUATF] [varchar](1) NOT NULL,
	[F4_TPIPI] [varchar](1) NOT NULL,
	[F4_STDESC] [varchar](1) NOT NULL,
	[F4_BSICMST] [float] NOT NULL,
	[F4_CREDST] [varchar](1) NOT NULL,
	[F4_BASEISS] [float] NOT NULL,
	[F4_DESPICM] [varchar](1) NOT NULL,
	[F4_SITTRIB] [varchar](2) NOT NULL,
	[F4_PISCOF] [varchar](1) NOT NULL,
	[F4_PISCRED] [varchar](1) NOT NULL,
	[F4_TESDV] [varchar](3) NOT NULL,
	[F4_BASEPIS] [float] NOT NULL,
	[F4_BASECOF] [float] NOT NULL,
	[F4_IPILICM] [varchar](1) NOT NULL,
	[F4_MOVPRJ] [varchar](1) NOT NULL,
	[F4_ICMSDIF] [varchar](1) NOT NULL,
	[F4_TESP3] [varchar](3) NOT NULL,
	[F4_QTDZERO] [varchar](1) NOT NULL,
	[F4_SLDNPT] [varchar](1) NOT NULL,
	[F4_DEVZERO] [varchar](1) NOT NULL,
	[F4_TIPOPER] [varchar](1) NOT NULL,
	[F4_MSBLQL] [varchar](1) NOT NULL,
	[F4_TRFICM] [varchar](1) NOT NULL,
	[F4_TESENV] [varchar](3) NOT NULL,
	[F4_OBSICM] [varchar](1) NOT NULL,
	[F4_OBSSOL] [varchar](1) NOT NULL,
	[F4_PICMDIF] [float] NOT NULL,
	[F4_SELO] [varchar](1) NOT NULL,
	[F4_ISSST] [varchar](1) NOT NULL,
	[F4_FINALID] [varchar](254) NOT NULL,
	[F4_PISFISC] [varchar](1) NOT NULL,
	[F4_CONTSOC] [varchar](1) NOT NULL,
	[F4_RETISS] [varchar](1) NOT NULL,
	[F4_CRDEST] [varchar](1) NOT NULL,
	[F4_PISBRUT] [varchar](1) NOT NULL,
	[F4_COFBRUT] [varchar](1) NOT NULL,
	[F4_PISDSZF] [varchar](1) NOT NULL,
	[F4_COFDSZF] [varchar](1) NOT NULL,
	[F4_LFICMST] [varchar](1) NOT NULL,
	[F4_AGRPIS] [varchar](1) NOT NULL,
	[F4_AGRCOF] [varchar](1) NOT NULL,
	[F4_BCRDPIS] [float] NOT NULL,
	[F4_BCRDCOF] [float] NOT NULL,
	[F4_ICMSST] [varchar](1) NOT NULL,
	[F4_BENSATF] [varchar](1) NOT NULL,
	[F4_IPIPC] [varchar](1) NOT NULL,
	[F4_CRPRST] [float] NOT NULL,
	[F4_TRANFIL] [varchar](1) NOT NULL,
	[F4_REGDSTA] [varchar](1) NOT NULL,
	[F4_OPEMOV] [varchar](2) NOT NULL,
	[F4_AFRMM] [varchar](1) NOT NULL,
	[F4_CRDPRES] [float] NOT NULL,
	[F4_DSPRDIC] [varchar](1) NOT NULL,
	[F4_TPREG] [varchar](1) NOT NULL,
	[F4_CRPRELE] [float] NOT NULL,
	[F4_AGRRETC] [varchar](1) NOT NULL,
	[F4_CTIPI] [varchar](2) NOT NULL,
	[F4_FRETAUT] [varchar](1) NOT NULL,
	[F4_MKPCMP] [varchar](1) NOT NULL,
	[F4_TESE3] [varchar](3) NOT NULL,
	[F4_PSCFST] [varchar](1) NOT NULL,
	[F4_IPIOBS] [varchar](1) NOT NULL,
	[F4_CFPS] [varchar](6) NOT NULL,
	[F4_CRDTRAN] [float] NOT NULL,
	[F4_ANTICMS] [varchar](1) NOT NULL,
	[F4_ESTCRED] [float] NOT NULL,
	[F4_MKPSOL] [varchar](1) NOT NULL,
	[F4_CRPREPR] [float] NOT NULL,
	[F4_BCPCST] [varchar](1) NOT NULL,
	[F4_CLFDSUL] [varchar](1) NOT NULL,
	[F4_COMPRED] [varchar](1) NOT NULL,
	[F4_CSTPIS] [varchar](2) NOT NULL,
	[F4_CSTCOF] [varchar](2) NOT NULL,
	[F4_RGESPST] [varchar](1) NOT NULL,
	[F4_CALCFET] [varchar](1) NOT NULL,
	[D_E_L_E_T_] [varchar](1) NOT NULL,
	[R_E_C_N_O_] [int] NOT NULL,
	[R_E_C_D_E_L_] [int] NOT NULL,
	[F4_TRANSIT] [varchar](1) NOT NULL,
	[F4_AGRDRED] [varchar](1) NOT NULL,
	[F4_CREDACU] [varchar](1) NOT NULL,
	[F4_PCREDAC] [float] NOT NULL,
	[F4_OPERSUC] [varchar](1) NOT NULL,
	[F4_CRPRSIM] [float] NOT NULL,
	[F4_DESCOND] [varchar](1) NOT NULL,
	[F4_CRPRERO] [float] NOT NULL,
	[F4_ISEFECP] [varchar](1) NOT NULL,
	[F4_INTBSIC] [varchar](1) NOT NULL,
	[F4_CRICMS] [varchar](1) NOT NULL,
	[F4_X_DESCR] [varchar](40) NOT NULL,
	[F4_X_COD] [varchar](3) NOT NULL,
	[F4_X_CDEB] [varchar](20) NOT NULL,
	[F4_X_CCRE] [varchar](20) NOT NULL,
	[F4_X_ICMDE] [varchar](20) NOT NULL,
	[F4_X_ICMCR] [varchar](20) NOT NULL,
	[F4_X_IPIDE] [varchar](20) NOT NULL,
	[F4_X_IPICR] [varchar](20) NOT NULL,
	[F4_X_PISDE] [varchar](20) NOT NULL,
	[F4_X_PISCR] [varchar](20) NOT NULL,
	[F4_X_COFDE] [varchar](20) NOT NULL,
	[F4_X_COFCR] [varchar](20) NOT NULL,
	[F4_X_CSLDE] [varchar](20) NOT NULL,
	[F4_X_CSLCR] [varchar](20) NOT NULL,
	[F4_X_SUBDE] [varchar](20) NOT NULL,
	[F4_X_SUBCR] [varchar](20) NOT NULL,
	[F4_X_CONT] [varchar](1) NOT NULL,
	[F4_X_HIST] [varchar](40) NOT NULL,
	[F4_X_MENNF] [varchar](3) NOT NULL,
	[F4_X_TIPO] [varchar](1) NOT NULL,
	[F4__STPISO] [varchar](2) NOT NULL,
	[F4__STCOFO] [varchar](2) NOT NULL,
	[F4__STPISN] [varchar](2) NOT NULL,
	[F4__STCOFN] [varchar](2) NOT NULL,
	[F4_X_ISSDE] [varchar](20) NOT NULL,
	[F4_X_ISSCR] [varchar](20) NOT NULL,
	[F4_CRDACUM] [varchar](1) NOT NULL,
	[F4_IVAUTIL] [float] NOT NULL,
	[F4_PERCMED] [float] NOT NULL,
	[F4_CODDET] [varchar](4) NOT NULL,
	[F4_TIPODUB] [varchar](1) NOT NULL,
	[F4_BENDUB] [varchar](1) NOT NULL,
	[F4_NUMDUB] [varchar](12) NOT NULL,
	[F4_DBSTCSL] [varchar](1) NOT NULL,
	[F4_DBSTIRR] [varchar](1) NOT NULL,
	[F4_CROUTGO] [float] NOT NULL,
	[F4_CSTISS] [varchar](2) NOT NULL,
	[F4_REFATAN] [varchar](1) NOT NULL,
	[F4_DUPLIST] [varchar](1) NOT NULL,
	[F4_BSRDICM] [varchar](1) NOT NULL,
	[F4_CFACS] [varchar](1) NOT NULL,
	[F4_CFABOV] [varchar](1) NOT NULL,
	[F4_VARATAC] [varchar](1) NOT NULL,
	[F4_MOVFIS] [varchar](1) NOT NULL,
	[F4_PRZESP] [varchar](1) NOT NULL,
	[F4_VLAGREG] [varchar](1) NOT NULL,
	[F4_APLIRED] [varchar](1) NOT NULL,
	[F4_APLIIVA] [varchar](1) NOT NULL,
	[F4_APLREDP] [varchar](1) NOT NULL,
	[F4_PAUTICM] [varchar](1) NOT NULL,
	[F4_ATACVAR] [varchar](1) NOT NULL,
	[F4_STCONF] [varchar](1) NOT NULL,
	[F4_BSRURAL] [varchar](1) NOT NULL,
	[F4_REDANT] [float] NOT NULL,
	[F4_CRPRESP] [float] NOT NULL,
	[F4_CPRESPR] [float] NOT NULL,
	[F4_CRPREPE] [float] NOT NULL,
	[F4_MOTICMS] [varchar](2) NOT NULL,
	[F4_ICMSTMT] [varchar](1) NOT NULL,
	[F4_CROUTSP] [float] NOT NULL,
	[F4_CSOSN] [varchar](3) NOT NULL,
	[F4_ART274] [varchar](1) NOT NULL,
	[F4_CODPAG] [varchar](2) NOT NULL,
	[F4_PAGCOM] [varchar](1) NOT NULL,
	[F4_VDASOFT] [varchar](1) NOT NULL,
	[F4_COP] [varchar](4) NOT NULL,
	[F4_TRAFILI] [varchar](1) NOT NULL,
	[F4_AJUSTE] [varchar](1) NOT NULL,
	[F4_CODBCC] [varchar](2) NOT NULL,
	[F4_INDNTFR] [varchar](1) NOT NULL,
	[F4_FRETISS] [varchar](1) NOT NULL,
	[F4_ALSENAR] [float] NOT NULL,
	[F4_AGREGCP] [varchar](1) NOT NULL,
	[F4_CRLEIT] [varchar](1) NOT NULL,
	[F4_PR35701] [float] NOT NULL,
	[F4_DESPPIS] [varchar](1) NOT NULL,
	[F4_DESPCOF] [varchar](1) NOT NULL,
	[F4_CODLAN] [varchar](6) NOT NULL,
	[F4_CPPRODE] [float] NOT NULL,
	[F4_TPPRODE] [varchar](1) NOT NULL,
	[F4_TEMDOCS] [varchar](1) NOT NULL,
	[F4_VENPRES] [varchar](1) NOT NULL,
	[F4_REDBCCE] [float] NOT NULL,
	[F4_CODLEG] [varchar](4) NOT NULL,
	[F4_COMPONE] [varchar](1) NOT NULL,
	[F4_REGESP] [varchar](2) NOT NULL,
	[F4_RGESPCI] [varchar](1) NOT NULL,
	[F4_TABGIAI] [varchar](3) NOT NULL,
	[F4_TABGIAO] [varchar](3) NOT NULL,
	[F4_TNATREC] [varchar](4) NOT NULL,
	[F4_CNATREC] [varchar](3) NOT NULL,
	[F4_GRPNATR] [varchar](2) NOT NULL,
	[F4_DTFIMNT] [varchar](8) NOT NULL,
	[F4_ISEFERN] [varchar](1) NOT NULL,
	[F4_CODOBSE] [varchar](6) NOT NULL,
	[F4_CRICMST] [varchar](1) NOT NULL,
	[F4_VLRZERO] [varchar](1) NOT NULL,
	[F4_NORESP] [varchar](1) NOT NULL,
	[F4_TPDUP] [varchar](1) NOT NULL,
	[F4_MALQCOF] [float] NOT NULL,
	[F4_TABGIAC] [varchar](3) NOT NULL,
	[F4_TPCPRES] [varchar](1) NOT NULL,
	[F4_CONSIND] [varchar](1) NOT NULL,
	[F4_ISEFEMG] [varchar](1) NOT NULL,
	[F4_ISEFEMT] [varchar](1) NOT NULL,
	[F4_APSCFST] [varchar](1) NOT NULL,
	[F4_SOMAIPI] [varchar](1) NOT NULL,
	[F4_CREDPRE] [float] NOT NULL,
	[F4_TPRSPL] [varchar](1) NOT NULL,
	[F4_CPRECTR] [varchar](1) NOT NULL,
	[F4_IPIANT] [varchar](1) NOT NULL,
	[F4_CTBHISS] [varchar](9) NOT NULL,
	[F4_CSBHISS] [varchar](5) NOT NULL,
	[F4_MTRTBH] [varchar](2) NOT NULL,
	[F4_RECDAC] [varchar](1) NOT NULL,
	[F4_NATOPER] [varchar](10) NOT NULL,
	[F4_MSGLT] [varchar](1) NOT NULL,
	[F4_TIPOTES] [varchar](1) NOT NULL,
	[F4_BONIF] [varchar](1) NOT NULL,
	[F4_RESSARC] [varchar](1) NOT NULL,
	[F4_CIAPTRB] [varchar](1) NOT NULL,
	[F4_FTATUSC] [varchar](1) NOT NULL,
	[F4_MALQPIS] [float] NOT NULL,
	[F4_DICMFUN] [varchar](1) NOT NULL,
	[F4_DESTRUI] [varchar](1) NOT NULL,
	[F4_PERCATM] [float] NOT NULL,
	[F4_STLIQ] [varchar](1) NOT NULL,
	[F4_RFETALG] [varchar](1) NOT NULL,
	[F4_IMPIND] [varchar](1) NOT NULL,
	[F4_DEVPARC] [varchar](1) NOT NULL,
	[F4_ESCRDPR] [varchar](1) NOT NULL,
	[F4_OPERGAR] [varchar](1) NOT NULL,
	[F4_INDDET] [varchar](1) NOT NULL,
	[F4_PARTICM] [varchar](1) NOT NULL,
	[F4_X_CMDEB] [varchar](20) NOT NULL,
	[F4_X_CMCRE] [varchar](20) NOT NULL,
	[F4_CV139] [varchar](1) NOT NULL,
	[F4_ALICRST] [float] NOT NULL,
	[F4_BSICMRE] [varchar](1) NOT NULL,
	[F4_IPIVFCF] [varchar](1) NOT NULL,
	[F4_RDBSICM] [varchar](1) NOT NULL,
	[F4_INOVAUT] [varchar](1) NOT NULL,
	[F4_CFAMAD] [varchar](1) NOT NULL,
	[F4_IDHIST] [varchar](20) NOT NULL,
	[F4_TRFICST] [varchar](1) NOT NULL,
	[F4_OUTPERC] [float] NOT NULL,
	[F4_PISMIN] [varchar](1) NOT NULL,
	[F4_COFMIN] [varchar](1) NOT NULL,
	[F4_IPIMIN] [varchar](1) NOT NULL,
	[F4_DESCISS] [varchar](1) NOT NULL,
	[F4_ENQLEG] [varchar](2) NOT NULL,
	[F4_IPMSP] [varchar](60) NOT NULL,
	[F4_IPMMG] [varchar](60) NOT NULL,
	[F4_TREGDMA] [varchar](2) NOT NULL,
	[F4_CUSENTR] [varchar](1) NOT NULL,
	[F4_IPIPECR] [float] NOT NULL,
	[F4_TXAPIPI] [varchar](3) NOT NULL,
	[F4_GRPCST] [varchar](3) NOT NULL,
	[F4_CALCCPB] [varchar](1) NOT NULL,
	[F4_DIFAL] [varchar](1) NOT NULL,
	[F4_BASCMP] [float] NOT NULL,
	[F4_DUPLIPI] [varchar](1) NOT NULL,
	[F4_EFDF100] [varchar](1) NOT NULL,
	[F4_CSTPF1] [varchar](2) NOT NULL,
	[F4_CSTCF1] [varchar](2) NOT NULL,
	[F4_FTRICMS] [float] NOT NULL,
	[F4_AGRISS] [varchar](1) NOT NULL,
	[F4_CFUNDES] [varchar](1) NOT NULL,
	[F4_CIMAMT] [varchar](1) NOT NULL,
	[F4_CFASE] [varchar](1) NOT NULL,
	[F4_INDVF] [varchar](1) NOT NULL,
	[F4_AGRPEDG] [varchar](1) NOT NULL,
 CONSTRAINT [SF4010_PK] PRIMARY KEY CLUSTERED 
(
	[R_E_C_N_O_] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ACY010] ADD  CONSTRAINT [ACY010_ACY_FILIAL_DF]  DEFAULT ('  ') FOR [ACY_FILIAL]
GO
ALTER TABLE [dbo].[ACY010] ADD  CONSTRAINT [ACY010_ACY_GRPVEN_DF]  DEFAULT ('      ') FOR [ACY_GRPVEN]
GO
ALTER TABLE [dbo].[ACY010] ADD  CONSTRAINT [ACY010_ACY_DESCRI_DF]  DEFAULT ('                              ') FOR [ACY_DESCRI]
GO
ALTER TABLE [dbo].[ACY010] ADD  CONSTRAINT [ACY010_ACY_GRPSUP_DF]  DEFAULT ('      ') FOR [ACY_GRPSUP]
GO
ALTER TABLE [dbo].[ACY010] ADD  CONSTRAINT [ACY010_ACY_CHAVE_DF]  DEFAULT ('                    ') FOR [ACY_CHAVE]
GO
ALTER TABLE [dbo].[ACY010] ADD  CONSTRAINT [ACY010_D_E_L_E_T__DF]  DEFAULT (' ') FOR [D_E_L_E_T_]
GO
ALTER TABLE [dbo].[ACY010] ADD  CONSTRAINT [ACY010_R_E_C_N_O__DF]  DEFAULT ((0)) FOR [R_E_C_N_O_]
GO
ALTER TABLE [dbo].[ACY010] ADD  CONSTRAINT [ACY010_R_E_C_D_E_L__DF]  DEFAULT ((0)) FOR [R_E_C_D_E_L_]
GO
ALTER TABLE [dbo].[ACY010] ADD  CONSTRAINT [ACY010_ACY_X_JRCP_DF]  DEFAULT (' ') FOR [ACY_X_JRCP]
GO
ALTER TABLE [dbo].[ACY010] ADD  CONSTRAINT [ACY010_ACY_X_COMZ_DF]  DEFAULT (' ') FOR [ACY_X_COMZ]
GO
ALTER TABLE [dbo].[ACY010] ADD  CONSTRAINT [ACY010_ACY_X_CBAN_DF]  DEFAULT (' ') FOR [ACY_X_CBAN]
GO
ALTER TABLE [dbo].[ACY010] ADD  CONSTRAINT [ACY010_ACY_X_AGCN_DF]  DEFAULT (' ') FOR [ACY_X_AGCN]
GO
ALTER TABLE [dbo].[ACY010] ADD  CONSTRAINT [ACY010_ACY_X_TARB_DF]  DEFAULT (' ') FOR [ACY_X_TARB]
GO
ALTER TABLE [dbo].[ACY010] ADD  CONSTRAINT [ACY010_ACY_X_COMI_DF]  DEFAULT (' ') FOR [ACY_X_COMI]
GO
ALTER TABLE [dbo].[ACY010] ADD  CONSTRAINT [ACY010_ACY_X_PROT_DF]  DEFAULT (' ') FOR [ACY_X_PROT]
GO
ALTER TABLE [dbo].[ACY010] ADD  CONSTRAINT [ACY010_ACY_X_DIAB_DF]  DEFAULT ((0)) FOR [ACY_X_DIAB]
GO
ALTER TABLE [dbo].[ACY010] ADD  CONSTRAINT [ACY010_ACY_X_TAB_DF]  DEFAULT ('   ') FOR [ACY_X_TAB]
GO
ALTER TABLE [dbo].[ACY010] ADD  CONSTRAINT [ACY010_ACY_X_COM_DF]  DEFAULT ((0)) FOR [ACY_X_COM]
GO
ALTER TABLE [dbo].[ACY010] ADD  CONSTRAINT [ACY010_ACY_X_MARG_DF]  DEFAULT ((0)) FOR [ACY_X_MARG]
GO
ALTER TABLE [dbo].[ACY010] ADD  CONSTRAINT [ACY010_ACY_X_FRET_DF]  DEFAULT ((0)) FOR [ACY_X_FRET]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_FILIAL_DF]  DEFAULT ('  ') FOR [A1_FILIAL]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_COD_DF]  DEFAULT ('      ') FOR [A1_COD]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_LOJA_DF]  DEFAULT ('  ') FOR [A1_LOJA]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_NOME_DF]  DEFAULT ('                                        ') FOR [A1_NOME]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_PESSOA_DF]  DEFAULT (' ') FOR [A1_PESSOA]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_NREDUZ_DF]  DEFAULT ('                    ') FOR [A1_NREDUZ]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_END_DF]  DEFAULT ('                                        ') FOR [A1_END]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_TIPO_DF]  DEFAULT (' ') FOR [A1_TIPO]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_EST_DF]  DEFAULT ('  ') FOR [A1_EST]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_ESTADO_DF]  DEFAULT ('                    ') FOR [A1_ESTADO]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_COD_MUN_DF]  DEFAULT ('     ') FOR [A1_COD_MUN]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_MUN_DF]  DEFAULT ('                         ') FOR [A1_MUN]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_NATUREZ_DF]  DEFAULT ('          ') FOR [A1_NATUREZ]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_BAIRRO_DF]  DEFAULT ('                              ') FOR [A1_BAIRRO]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CEP_DF]  DEFAULT ('        ') FOR [A1_CEP]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_DDI_DF]  DEFAULT ('      ') FOR [A1_DDI]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_DDD_DF]  DEFAULT ('   ') FOR [A1_DDD]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_TEL_DF]  DEFAULT ('               ') FOR [A1_TEL]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_TELEX_DF]  DEFAULT ('          ') FOR [A1_TELEX]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_FAX_DF]  DEFAULT ('               ') FOR [A1_FAX]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_ENDCOB_DF]  DEFAULT ('                                        ') FOR [A1_ENDCOB]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_PAIS_DF]  DEFAULT ('   ') FOR [A1_PAIS]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_ENDENT_DF]  DEFAULT ('                                        ') FOR [A1_ENDENT]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_ENDREC_DF]  DEFAULT ('                                        ') FOR [A1_ENDREC]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CONTATO_DF]  DEFAULT ('               ') FOR [A1_CONTATO]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CGC_DF]  DEFAULT ('              ') FOR [A1_CGC]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_INSCR_DF]  DEFAULT ('                  ') FOR [A1_INSCR]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_PFISICA_DF]  DEFAULT ('                  ') FOR [A1_PFISICA]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_INSCRM_DF]  DEFAULT ('                  ') FOR [A1_INSCRM]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_VEND_DF]  DEFAULT ('      ') FOR [A1_VEND]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_COMIS_DF]  DEFAULT ((0)) FOR [A1_COMIS]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_REGIAO_DF]  DEFAULT ('   ') FOR [A1_REGIAO]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CONTA_DF]  DEFAULT ('                    ') FOR [A1_CONTA]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_BCO1_DF]  DEFAULT ('   ') FOR [A1_BCO1]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_BCO2_DF]  DEFAULT ('   ') FOR [A1_BCO2]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_BCO3_DF]  DEFAULT ('   ') FOR [A1_BCO3]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_BCO4_DF]  DEFAULT ('   ') FOR [A1_BCO4]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_BCO5_DF]  DEFAULT ('   ') FOR [A1_BCO5]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_TRANSP_DF]  DEFAULT ('      ') FOR [A1_TRANSP]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_TPFRET_DF]  DEFAULT (' ') FOR [A1_TPFRET]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_COND_DF]  DEFAULT ('   ') FOR [A1_COND]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_DESC_DF]  DEFAULT ((0)) FOR [A1_DESC]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_PRIOR_DF]  DEFAULT (' ') FOR [A1_PRIOR]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_RISCO_DF]  DEFAULT (' ') FOR [A1_RISCO]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_LC_DF]  DEFAULT ((0)) FOR [A1_LC]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_VENCLC_DF]  DEFAULT ('        ') FOR [A1_VENCLC]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CLASSE_DF]  DEFAULT (' ') FOR [A1_CLASSE]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_LCFIN_DF]  DEFAULT ((0)) FOR [A1_LCFIN]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_MOEDALC_DF]  DEFAULT ((0)) FOR [A1_MOEDALC]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_MSALDO_DF]  DEFAULT ((0)) FOR [A1_MSALDO]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_MCOMPRA_DF]  DEFAULT ((0)) FOR [A1_MCOMPRA]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_METR_DF]  DEFAULT ((0)) FOR [A1_METR]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_PRICOM_DF]  DEFAULT ('        ') FOR [A1_PRICOM]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_ULTCOM_DF]  DEFAULT ('        ') FOR [A1_ULTCOM]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_NROCOM_DF]  DEFAULT ((0)) FOR [A1_NROCOM]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_FORMVIS_DF]  DEFAULT ('   ') FOR [A1_FORMVIS]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_TEMVIS_DF]  DEFAULT ((0)) FOR [A1_TEMVIS]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_ULTVIS_DF]  DEFAULT ('        ') FOR [A1_ULTVIS]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_TMPVIS_DF]  DEFAULT ('     ') FOR [A1_TMPVIS]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_TMPSTD_DF]  DEFAULT ('     ') FOR [A1_TMPSTD]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CLASVEN_DF]  DEFAULT (' ') FOR [A1_CLASVEN]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_MENSAGE_DF]  DEFAULT ('   ') FOR [A1_MENSAGE]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_SALDUP_DF]  DEFAULT ((0)) FOR [A1_SALDUP]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_RECISS_DF]  DEFAULT (' ') FOR [A1_RECISS]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_NROPAG_DF]  DEFAULT ((0)) FOR [A1_NROPAG]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_SALPEDL_DF]  DEFAULT ((0)) FOR [A1_SALPEDL]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_TRANSF_DF]  DEFAULT (' ') FOR [A1_TRANSF]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_SUFRAMA_DF]  DEFAULT ('            ') FOR [A1_SUFRAMA]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_ATR_DF]  DEFAULT ((0)) FOR [A1_ATR]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_VACUM_DF]  DEFAULT ((0)) FOR [A1_VACUM]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_SALPED_DF]  DEFAULT ((0)) FOR [A1_SALPED]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_TITPROT_DF]  DEFAULT ((0)) FOR [A1_TITPROT]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_DTULTIT_DF]  DEFAULT ('        ') FOR [A1_DTULTIT]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CHQDEVO_DF]  DEFAULT ((0)) FOR [A1_CHQDEVO]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_DTULCHQ_DF]  DEFAULT ('        ') FOR [A1_DTULCHQ]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_MATR_DF]  DEFAULT ((0)) FOR [A1_MATR]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_MAIDUPL_DF]  DEFAULT ((0)) FOR [A1_MAIDUPL]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_TABELA_DF]  DEFAULT ('   ') FOR [A1_TABELA]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_INCISS_DF]  DEFAULT (' ') FOR [A1_INCISS]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_SALDUPM_DF]  DEFAULT ((0)) FOR [A1_SALDUPM]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_PAGATR_DF]  DEFAULT ((0)) FOR [A1_PAGATR]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CXPOSTA_DF]  DEFAULT ('                    ') FOR [A1_CXPOSTA]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_ATIVIDA_DF]  DEFAULT ('       ') FOR [A1_ATIVIDA]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CARGO1_DF]  DEFAULT ('               ') FOR [A1_CARGO1]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CARGO2_DF]  DEFAULT ('               ') FOR [A1_CARGO2]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CARGO3_DF]  DEFAULT ('               ') FOR [A1_CARGO3]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_SUPER_DF]  DEFAULT ('      ') FOR [A1_SUPER]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_RTEC_DF]  DEFAULT ('      ') FOR [A1_RTEC]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_ALIQIR_DF]  DEFAULT ((0)) FOR [A1_ALIQIR]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_OBSERV_DF]  DEFAULT ('                                        ') FOR [A1_OBSERV]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_RG_DF]  DEFAULT ('               ') FOR [A1_RG]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CALCSUF_DF]  DEFAULT (' ') FOR [A1_CALCSUF]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_DTNASC_DF]  DEFAULT ('        ') FOR [A1_DTNASC]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_SALPEDB_DF]  DEFAULT ((0)) FOR [A1_SALPEDB]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CLIFAT_DF]  DEFAULT ('      ') FOR [A1_CLIFAT]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_GRPTRIB_DF]  DEFAULT ('   ') FOR [A1_GRPTRIB]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_BAIRROC_DF]  DEFAULT ('                              ') FOR [A1_BAIRROC]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CEPC_DF]  DEFAULT ('        ') FOR [A1_CEPC]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_MUNC_DF]  DEFAULT ('               ') FOR [A1_MUNC]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_ESTC_DF]  DEFAULT ('  ') FOR [A1_ESTC]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_BAIRROE_DF]  DEFAULT ('                    ') FOR [A1_BAIRROE]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CEPE_DF]  DEFAULT ('        ') FOR [A1_CEPE]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_MUNE_DF]  DEFAULT ('               ') FOR [A1_MUNE]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_ESTE_DF]  DEFAULT ('  ') FOR [A1_ESTE]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_SATIV1_DF]  DEFAULT ('      ') FOR [A1_SATIV1]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_SATIV2_DF]  DEFAULT ('      ') FOR [A1_SATIV2]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CODPAIS_DF]  DEFAULT ('     ') FOR [A1_CODPAIS]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_TPESSOA_DF]  DEFAULT ('  ') FOR [A1_TPESSOA]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CODLOC_DF]  DEFAULT ('        ') FOR [A1_CODLOC]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_TPISSRS_DF]  DEFAULT ('  ') FOR [A1_TPISSRS]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_SATIV3_DF]  DEFAULT ('      ') FOR [A1_SATIV3]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_SATIV4_DF]  DEFAULT ('      ') FOR [A1_SATIV4]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_SATIV5_DF]  DEFAULT ('      ') FOR [A1_SATIV5]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_SATIV6_DF]  DEFAULT ('      ') FOR [A1_SATIV6]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_SATIV7_DF]  DEFAULT ('      ') FOR [A1_SATIV7]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_SATIV8_DF]  DEFAULT ('      ') FOR [A1_SATIV8]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CODMARC_DF]  DEFAULT ('      ') FOR [A1_CODMARC]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CODAGE_DF]  DEFAULT ('   ') FOR [A1_CODAGE]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_COMAGE_DF]  DEFAULT ((0)) FOR [A1_COMAGE]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_TIPCLI_DF]  DEFAULT (' ') FOR [A1_TIPCLI]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_EMAIL_DF]  DEFAULT ('                                                            ') FOR [A1_EMAIL]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_DEST_1_DF]  DEFAULT ('   ') FOR [A1_DEST_1]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_DEST_2_DF]  DEFAULT ('   ') FOR [A1_DEST_2]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CODMUN_DF]  DEFAULT ('     ') FOR [A1_CODMUN]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_HPAGE_DF]  DEFAULT ('                              ') FOR [A1_HPAGE]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_DEST_3_DF]  DEFAULT ('   ') FOR [A1_DEST_3]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CBO_DF]  DEFAULT ('       ') FOR [A1_CBO]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CNAE_DF]  DEFAULT ('         ') FOR [A1_CNAE]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CONDPAG_DF]  DEFAULT ('     ') FOR [A1_CONDPAG]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_DIASPAG_DF]  DEFAULT ((0)) FOR [A1_DIASPAG]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_OBS_DF]  DEFAULT ('      ') FOR [A1_OBS]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_AGREG_DF]  DEFAULT ('    ') FOR [A1_AGREG]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CODHIST_DF]  DEFAULT ('      ') FOR [A1_CODHIST]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_RECINSS_DF]  DEFAULT (' ') FOR [A1_RECINSS]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_RECCOFI_DF]  DEFAULT (' ') FOR [A1_RECCOFI]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_RECCSLL_DF]  DEFAULT (' ') FOR [A1_RECCSLL]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_RECPIS_DF]  DEFAULT (' ') FOR [A1_RECPIS]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_TIPPER_DF]  DEFAULT ('  ') FOR [A1_TIPPER]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_SALFIN_DF]  DEFAULT ((0)) FOR [A1_SALFIN]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_SALFINM_DF]  DEFAULT ((0)) FOR [A1_SALFINM]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CONTAB_DF]  DEFAULT ('               ') FOR [A1_CONTAB]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_B2B_DF]  DEFAULT (' ') FOR [A1_B2B]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_GRPVEN_DF]  DEFAULT ('      ') FOR [A1_GRPVEN]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CLICNV_DF]  DEFAULT (' ') FOR [A1_CLICNV]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_MSBLQL_DF]  DEFAULT (' ') FOR [A1_MSBLQL]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_INSCRUR_DF]  DEFAULT ('                  ') FOR [A1_INSCRUR]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_SITUA_DF]  DEFAULT ('  ') FOR [A1_SITUA]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_NUMRA_DF]  DEFAULT ('               ') FOR [A1_NUMRA]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_SUBCOD_DF]  DEFAULT (' ') FOR [A1_SUBCOD]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CDRDES_DF]  DEFAULT ('      ') FOR [A1_CDRDES]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_FILDEB_DF]  DEFAULT ('  ') FOR [A1_FILDEB]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CODFOR_DF]  DEFAULT ('               ') FOR [A1_CODFOR]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_ABICS_DF]  DEFAULT ('    ') FOR [A1_ABICS]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_BLEMAIL_DF]  DEFAULT (' ') FOR [A1_BLEMAIL]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_TIPOCLI_DF]  DEFAULT ('  ') FOR [A1_TIPOCLI]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_VINCULO_DF]  DEFAULT ('  ') FOR [A1_VINCULO]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_DTINIV_DF]  DEFAULT ('        ') FOR [A1_DTINIV]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_DTFIMV_DF]  DEFAULT ('        ') FOR [A1_DTFIMV]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_LOCCONS_DF]  DEFAULT ('  ') FOR [A1_LOCCONS]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_PERFIL_DF]  DEFAULT ((0)) FOR [A1_PERFIL]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_HRTRANS_DF]  DEFAULT ('     ') FOR [A1_HRTRANS]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_UNIDVEN_DF]  DEFAULT ('      ') FOR [A1_UNIDVEN]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_SIMPLES_DF]  DEFAULT (' ') FOR [A1_SIMPLES]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CEINSS_DF]  DEFAULT ('              ') FOR [A1_CEINSS]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_FRETISS_DF]  DEFAULT (' ') FOR [A1_FRETISS]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CTARE_DF]  DEFAULT (' ') FOR [A1_CTARE]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_ABATIMP_DF]  DEFAULT (' ') FOR [A1_ABATIMP]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_RECIRRF_DF]  DEFAULT (' ') FOR [A1_RECIRRF]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_TIMEKEE_DF]  DEFAULT ('        ') FOR [A1_TIMEKEE]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CONTRIB_DF]  DEFAULT (' ') FOR [A1_CONTRIB]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_COMPLEM_DF]  DEFAULT ('                                                  ') FOR [A1_COMPLEM]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_FOMEZER_DF]  DEFAULT (' ') FOR [A1_FOMEZER]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_RECFET_DF]  DEFAULT (' ') FOR [A1_RECFET]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_D_E_L_E_T__DF]  DEFAULT (' ') FOR [D_E_L_E_T_]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_R_E_C_N_O__DF]  DEFAULT ((0)) FOR [R_E_C_N_O_]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_R_E_C_D_E_L__DF]  DEFAULT ((0)) FOR [R_E_C_D_E_L_]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_SIMPNAC_DF]  DEFAULT (' ') FOR [A1_SIMPNAC]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CODSIAF_DF]  DEFAULT ('    ') FOR [A1_CODSIAF]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_PRSTSER_DF]  DEFAULT (' ') FOR [A1_PRSTSER]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_ALIFIXA_DF]  DEFAULT (' ') FOR [A1_ALIFIXA]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_ENDNOT_DF]  DEFAULT (' ') FOR [A1_ENDNOT]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_JRCOM_DF]  DEFAULT (' ') FOR [A1_X_JRCOM]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_COMZ_DF]  DEFAULT (' ') FOR [A1_X_COMZ]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_DTINC_DF]  DEFAULT ('        ') FOR [A1_X_DTINC]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_HRINC_DF]  DEFAULT ('        ') FOR [A1_X_HRINC]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_USINC_DF]  DEFAULT ('                    ') FOR [A1_X_USINC]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_CODFR_DF]  DEFAULT ('       ') FOR [A1_X_CODFR]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_DTCAD_DF]  DEFAULT ('        ') FOR [A1_X_DTCAD]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_ALERT_DF]  DEFAULT ('                                                                                                    ') FOR [A1_X_ALERT]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_ATEND_DF]  DEFAULT ((0)) FOR [A1_X_ATEND]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_FORMA_DF]  DEFAULT ('   ') FOR [A1_X_FORMA]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_CBAN_DF]  DEFAULT (' ') FOR [A1_X_CBAN]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_AGCN_DF]  DEFAULT (' ') FOR [A1_X_AGCN]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_CLBOL_DF]  DEFAULT ('      ') FOR [A1_X_CLBOL]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_LJBOL_DF]  DEFAULT ('  ') FOR [A1_X_LJBOL]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_TARBC_DF]  DEFAULT (' ') FOR [A1_X_TARBC]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_PROT_DF]  DEFAULT (' ') FOR [A1_X_PROT]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_VEND2_DF]  DEFAULT ('      ') FOR [A1_X_VEND2]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_VEND3_DF]  DEFAULT ('      ') FOR [A1_X_VEND3]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_TEL_DF]  DEFAULT ('                                                  ') FOR [A1_X_TEL]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_LOGBL_DF]  DEFAULT ('                                                            ') FOR [A1_X_LOGBL]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_TES_DF]  DEFAULT ('   ') FOR [A1_X_TES]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1__BLQAVU_DF]  DEFAULT (' ') FOR [A1__BLQAVU]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_IMPNE_DF]  DEFAULT (' ') FOR [A1_X_IMPNE]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1__GERFAT_DF]  DEFAULT (' ') FOR [A1__GERFAT]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_USUFR_DF]  DEFAULT ('      ') FOR [A1_X_USUFR]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_DFIN_DF]  DEFAULT ((0)) FOR [A1_X_DFIN]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_DTAB_DF]  DEFAULT ((0)) FOR [A1_X_DTAB]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_REGPB_DF]  DEFAULT (' ') FOR [A1_REGPB]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_RFACS_DF]  DEFAULT (' ') FOR [A1_RFACS]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_RFABOV_DF]  DEFAULT (' ') FOR [A1_RFABOV]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_INCULT_DF]  DEFAULT (' ') FOR [A1_INCULT]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_IMPBO_DF]  DEFAULT (' ') FOR [A1_X_IMPBO]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_VENDA_DF]  DEFAULT ('      ') FOR [A1_X_VENDA]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_IPWEB_DF]  DEFAULT ('                    ') FOR [A1_IPWEB]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CRDMA_DF]  DEFAULT (' ') FOR [A1_CRDMA]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_ENTID_DF]  DEFAULT ('  ') FOR [A1_ENTID]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_USADDA_DF]  DEFAULT (' ') FOR [A1_USADDA]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_MINIRF_DF]  DEFAULT (' ') FOR [A1_MINIRF]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_SERAS_DF]  DEFAULT (' ') FOR [A1_X_SERAS]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_REGESIM_DF]  DEFAULT (' ') FOR [A1_REGESIM]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_PERCATM_DF]  DEFAULT ((0)) FOR [A1_PERCATM]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_INDRET_DF]  DEFAULT ('  ') FOR [A1_INDRET]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_AGLPD_DF]  DEFAULT (' ') FOR [A1_X_AGLPD]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_MSN_DF]  DEFAULT ('                                                                                ') FOR [A1_X_MSN]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_CONT_DF]  DEFAULT ('                                                                                ') FOR [A1_X_CONT]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_PROF_DF]  DEFAULT (' ') FOR [A1_X_PROF]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_CRO_DF]  DEFAULT ('          ') FOR [A1_X_CRO]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_UFCRO_DF]  DEFAULT ('  ') FOR [A1_X_UFCRO]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_VECRO_DF]  DEFAULT (' ') FOR [A1_X_VECRO]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_TPJ_DF]  DEFAULT (' ') FOR [A1_TPJ]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_TRIBFAV_DF]  DEFAULT (' ') FOR [A1_TRIBFAV]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_PERFECP_DF]  DEFAULT ((0)) FOR [A1_PERFECP]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_OUTRMUN_DF]  DEFAULT ('          ') FOR [A1_OUTRMUN]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_TPNFSE_DF]  DEFAULT ('  ') FOR [A1_TPNFSE]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_IRBAX_DF]  DEFAULT (' ') FOR [A1_IRBAX]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_FILTRF_DF]  DEFAULT ('  ') FOR [A1_FILTRF]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_TDA_DF]  DEFAULT (' ') FOR [A1_TDA]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_IBGE_DF]  DEFAULT ('           ') FOR [A1_IBGE]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CBAIRRE_DF]  DEFAULT ('      ') FOR [A1_CBAIRRE]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CODMUNE_DF]  DEFAULT ('     ') FOR [A1_CODMUNE]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_TIPPRFL_DF]  DEFAULT (' ') FOR [A1_TIPPRFL]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_PRF_VLD_DF]  DEFAULT ('        ') FOR [A1_PRF_VLD]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_PRF_COD_DF]  DEFAULT ('      ') FOR [A1_PRF_COD]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_CODFID_DF]  DEFAULT ('                                        ') FOR [A1_CODFID]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_ORIGEM_DF]  DEFAULT ('  ') FOR [A1_ORIGEM]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_TPDP_DF]  DEFAULT (' ') FOR [A1_TPDP]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_SERA2_DF]  DEFAULT (' ') FOR [A1_X_SERA2]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_OPER_DF]  DEFAULT ('  ') FOR [A1_X_OPER]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_LCA_DF]  DEFAULT (' ') FOR [A1_X_LCA]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_INOVAUT_DF]  DEFAULT (' ') FOR [A1_INOVAUT]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_WORK1_DF]  DEFAULT (' ') FOR [A1_X_WORK1]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_WORK2_DF]  DEFAULT (' ') FOR [A1_X_WORK2]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_GRPV_DF]  DEFAULT ('      ') FOR [A1_X_GRPV]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_ESPEC_DF]  DEFAULT ('                              ') FOR [A1_X_ESPEC]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_PRADO_DF]  DEFAULT ((0)) FOR [A1_X_PRADO]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_RECFMD_DF]  DEFAULT (' ') FOR [A1_RECFMD]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_IDHIST_DF]  DEFAULT ('                    ') FOR [A1_IDHIST]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_NIF_DF]  DEFAULT ('                                        ') FOR [A1_NIF]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_MATFUN_DF]  DEFAULT ('      ') FOR [A1_MATFUN]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_IENCONT_DF]  DEFAULT (' ') FOR [A1_IENCONT]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_X_VLDSE_DF]  DEFAULT ('        ') FOR [A1_X_VLDSE]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_INCLTMG_DF]  DEFAULT (' ') FOR [A1_INCLTMG]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_RFUNDES_DF]  DEFAULT (' ') FOR [A1_RFUNDES]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_RIMAMT_DF]  DEFAULT (' ') FOR [A1_RIMAMT]
GO
ALTER TABLE [dbo].[SA1010] ADD  CONSTRAINT [SA1010_A1_RFASEMT_DF]  DEFAULT (' ') FOR [A1_RFASEMT]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_FILIAL_DF]  DEFAULT ('  ') FOR [A2_FILIAL]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_COD_DF]  DEFAULT ('      ') FOR [A2_COD]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_LOJA_DF]  DEFAULT ('  ') FOR [A2_LOJA]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_NOME_DF]  DEFAULT ('                                        ') FOR [A2_NOME]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_NREDUZ_DF]  DEFAULT ('                    ') FOR [A2_NREDUZ]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_END_DF]  DEFAULT ('                                        ') FOR [A2_END]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_NR_END_DF]  DEFAULT ('      ') FOR [A2_NR_END]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_BAIRRO_DF]  DEFAULT ('                    ') FOR [A2_BAIRRO]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_EST_DF]  DEFAULT ('  ') FOR [A2_EST]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_ESTADO_DF]  DEFAULT ('                    ') FOR [A2_ESTADO]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_COD_MUN_DF]  DEFAULT ('     ') FOR [A2_COD_MUN]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_MUN_DF]  DEFAULT ('               ') FOR [A2_MUN]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CEP_DF]  DEFAULT ('        ') FOR [A2_CEP]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CX_POST_DF]  DEFAULT ('     ') FOR [A2_CX_POST]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_TIPO_DF]  DEFAULT (' ') FOR [A2_TIPO]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CGC_DF]  DEFAULT ('              ') FOR [A2_CGC]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_PFISICA_DF]  DEFAULT ('                  ') FOR [A2_PFISICA]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_DDI_DF]  DEFAULT ('      ') FOR [A2_DDI]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_DDD_DF]  DEFAULT ('   ') FOR [A2_DDD]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_TEL_DF]  DEFAULT ('                                                  ') FOR [A2_TEL]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_FAX_DF]  DEFAULT ('               ') FOR [A2_FAX]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_INSCR_DF]  DEFAULT ('                  ') FOR [A2_INSCR]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_INSCRM_DF]  DEFAULT ('                  ') FOR [A2_INSCRM]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CONTATO_DF]  DEFAULT ('               ') FOR [A2_CONTATO]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_BANCO_DF]  DEFAULT ('   ') FOR [A2_BANCO]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_AGENCIA_DF]  DEFAULT ('     ') FOR [A2_AGENCIA]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_NUMCON_DF]  DEFAULT ('          ') FOR [A2_NUMCON]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_SWIFT_DF]  DEFAULT ('                              ') FOR [A2_SWIFT]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_NATUREZ_DF]  DEFAULT ('          ') FOR [A2_NATUREZ]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_TRANSP_DF]  DEFAULT ('      ') FOR [A2_TRANSP]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_PRIOR_DF]  DEFAULT (' ') FOR [A2_PRIOR]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_RISCO_DF]  DEFAULT ('   ') FOR [A2_RISCO]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_COND_DF]  DEFAULT ('   ') FOR [A2_COND]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_LC_DF]  DEFAULT ('              ') FOR [A2_LC]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_MATR_DF]  DEFAULT ((0)) FOR [A2_MATR]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_MCOMPRA_DF]  DEFAULT ((0)) FOR [A2_MCOMPRA]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_METR_DF]  DEFAULT ((0)) FOR [A2_METR]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_MSALDO_DF]  DEFAULT ((0)) FOR [A2_MSALDO]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_NROCOM_DF]  DEFAULT ((0)) FOR [A2_NROCOM]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_PRICOM_DF]  DEFAULT ('        ') FOR [A2_PRICOM]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_ULTCOM_DF]  DEFAULT ('        ') FOR [A2_ULTCOM]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_SALDUP_DF]  DEFAULT ((0)) FOR [A2_SALDUP]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_DESVIO_DF]  DEFAULT ((0)) FOR [A2_DESVIO]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_SALDUPM_DF]  DEFAULT ((0)) FOR [A2_SALDUPM]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CONTA_DF]  DEFAULT ('                    ') FOR [A2_CONTA]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_TIPORUR_DF]  DEFAULT (' ') FOR [A2_TIPORUR]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_RECISS_DF]  DEFAULT (' ') FOR [A2_RECISS]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_PAIS_DF]  DEFAULT ('   ') FOR [A2_PAIS]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_DEPTO_DF]  DEFAULT ('                              ') FOR [A2_DEPTO]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_ID_FBFN_DF]  DEFAULT ('       ') FOR [A2_ID_FBFN]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_STATUS_DF]  DEFAULT (' ') FOR [A2_STATUS]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_GRUPO_DF]  DEFAULT ('   ') FOR [A2_GRUPO]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_ATIVIDA_DF]  DEFAULT ('       ') FOR [A2_ATIVIDA]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_ORIG_1_DF]  DEFAULT ('   ') FOR [A2_ORIG_1]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_ORIG_2_DF]  DEFAULT ('   ') FOR [A2_ORIG_2]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_ORIG_3_DF]  DEFAULT ('   ') FOR [A2_ORIG_3]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_VINCULA_DF]  DEFAULT (' ') FOR [A2_VINCULA]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_REPRES_DF]  DEFAULT ('                                                    ') FOR [A2_REPRES]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_REPCONT_DF]  DEFAULT ('                                                  ') FOR [A2_REPCONT]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_REPRTEL_DF]  DEFAULT ('                                                  ') FOR [A2_REPRTEL]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_REPRFAX_DF]  DEFAULT ('                              ') FOR [A2_REPRFAX]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_REPR_EM_DF]  DEFAULT ('                              ') FOR [A2_REPR_EM]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_REPR_EN_DF]  DEFAULT ('                                                    ') FOR [A2_REPR_EN]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_REPBAIR_DF]  DEFAULT ('                              ') FOR [A2_REPBAIR]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_REPRMUN_DF]  DEFAULT ('                              ') FOR [A2_REPRMUN]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_REPREST_DF]  DEFAULT ('  ') FOR [A2_REPREST]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_REPRCEP_DF]  DEFAULT ('        ') FOR [A2_REPRCEP]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_REPPAIS_DF]  DEFAULT ('   ') FOR [A2_REPPAIS]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_ID_REPR_DF]  DEFAULT (' ') FOR [A2_ID_REPR]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_REPR_BA_DF]  DEFAULT ('   ') FOR [A2_REPR_BA]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_REPR_AG_DF]  DEFAULT ('     ') FOR [A2_REPR_AG]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_REPR_CO_DF]  DEFAULT ('          ') FOR [A2_REPR_CO]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_REPRCGC_DF]  DEFAULT ('              ') FOR [A2_REPRCGC]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_RET_PAI_DF]  DEFAULT (' ') FOR [A2_RET_PAI]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_COMI_SO_DF]  DEFAULT (' ') FOR [A2_COMI_SO]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_EMAIL_DF]  DEFAULT ('                                                            ') FOR [A2_EMAIL]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_HPAGE_DF]  DEFAULT ('                              ') FOR [A2_HPAGE]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CODMUN_DF]  DEFAULT ('     ') FOR [A2_CODMUN]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CONTCOM_DF]  DEFAULT ('               ') FOR [A2_CONTCOM]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_FATAVA_DF]  DEFAULT ((0)) FOR [A2_FATAVA]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_FABRICA_DF]  DEFAULT (' ') FOR [A2_FABRICA]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_DTAVA_DF]  DEFAULT ('        ') FOR [A2_DTAVA]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_DTVAL_DF]  DEFAULT ('        ') FOR [A2_DTVAL]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_OK_DF]  DEFAULT ('  ') FOR [A2_OK]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_RECINSS_DF]  DEFAULT (' ') FOR [A2_RECINSS]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_TELEX_DF]  DEFAULT ('          ') FOR [A2_TELEX]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CODLOC_DF]  DEFAULT ('        ') FOR [A2_CODLOC]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CODPAIS_DF]  DEFAULT ('     ') FOR [A2_CODPAIS]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_TPESSOA_DF]  DEFAULT ('  ') FOR [A2_TPESSOA]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_TPISSRS_DF]  DEFAULT ('  ') FOR [A2_TPISSRS]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_MNOTA_DF]  DEFAULT ((0)) FOR [A2_MNOTA]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_RECCIDE_DF]  DEFAULT (' ') FOR [A2_RECCIDE]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_GRPTRIB_DF]  DEFAULT ('   ') FOR [A2_GRPTRIB]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_UNFEDRP_DF]  DEFAULT ('                              ') FOR [A2_UNFEDRP]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CONTAB_DF]  DEFAULT ('               ') FOR [A2_CONTAB]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CLIQF_DF]  DEFAULT ('               ') FOR [A2_CLIQF]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_PLGRUPO_DF]  DEFAULT ('   ') FOR [A2_PLGRUPO]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CODBLO_DF]  DEFAULT ('   ') FOR [A2_CODBLO]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_PAISORI_DF]  DEFAULT ('                    ') FOR [A2_PAISORI]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_ROYALTY_DF]  DEFAULT (' ') FOR [A2_ROYALTY]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_TXTRIBU_DF]  DEFAULT ((0)) FOR [A2_TXTRIBU]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_B2B_DF]  DEFAULT (' ') FOR [A2_B2B]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_PLCRRES_DF]  DEFAULT (' ') FOR [A2_PLCRRES]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_PLFIL_DF]  DEFAULT (' ') FOR [A2_PLFIL]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_SIGLCR_DF]  DEFAULT ('       ') FOR [A2_SIGLCR]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CONREG_DF]  DEFAULT ('          ') FOR [A2_CONREG]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_DATBLO_DF]  DEFAULT ('        ') FOR [A2_DATBLO]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_PLPEDES_DF]  DEFAULT ((0)) FOR [A2_PLPEDES]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CBO_DF]  DEFAULT ('       ') FOR [A2_CBO]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CNAE_DF]  DEFAULT ('         ') FOR [A2_CNAE]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CIVIL_DF]  DEFAULT (' ') FOR [A2_CIVIL]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_ROYMIN_DF]  DEFAULT ((0)) FOR [A2_ROYMIN]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_SATIV1_DF]  DEFAULT ('      ') FOR [A2_SATIV1]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_PAGAMEN_DF]  DEFAULT (' ') FOR [A2_PAGAMEN]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_ENDCOMP_DF]  DEFAULT ('                     ') FOR [A2_ENDCOMP]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_MSBLQL_DF]  DEFAULT (' ') FOR [A2_MSBLQL]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_GRPDEP_DF]  DEFAULT ('     ') FOR [A2_GRPDEP]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_SUBCOD_DF]  DEFAULT (' ') FOR [A2_SUBCOD]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_TIPAWB_DF]  DEFAULT (' ') FOR [A2_TIPAWB]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_RECSEST_DF]  DEFAULT (' ') FOR [A2_RECSEST]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_FILDEB_DF]  DEFAULT ('  ') FOR [A2_FILDEB]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_RECPIS_DF]  DEFAULT (' ') FOR [A2_RECPIS]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_RECCOFI_DF]  DEFAULT (' ') FOR [A2_RECCOFI]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_RECCSLL_DF]  DEFAULT (' ') FOR [A2_RECCSLL]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_ABICS_DF]  DEFAULT ('    ') FOR [A2_ABICS]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CODFAV_DF]  DEFAULT ('      ') FOR [A2_CODFAV]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_LOJFAV_DF]  DEFAULT ('  ') FOR [A2_LOJFAV]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_NUMDEP_DF]  DEFAULT ((0)) FOR [A2_NUMDEP]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CALCIRF_DF]  DEFAULT (' ') FOR [A2_CALCIRF]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_VINCULO_DF]  DEFAULT ('  ') FOR [A2_VINCULO]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_DTINIV_DF]  DEFAULT ('        ') FOR [A2_DTINIV]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_DTFIMV_DF]  DEFAULT ('        ') FOR [A2_DTFIMV]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_RECFET_DF]  DEFAULT (' ') FOR [A2_RECFET]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_NUMRA_DF]  DEFAULT ('      ') FOR [A2_NUMRA]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CODINSS_DF]  DEFAULT ('           ') FOR [A2_CODINSS]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CTARE_DF]  DEFAULT (' ') FOR [A2_CTARE]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_COMPLEM_DF]  DEFAULT ('                                                  ') FOR [A2_COMPLEM]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_FOMEZER_DF]  DEFAULT (' ') FOR [A2_FOMEZER]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_FRETISS_DF]  DEFAULT (' ') FOR [A2_FRETISS]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_D_E_L_E_T__DF]  DEFAULT (' ') FOR [D_E_L_E_T_]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_R_E_C_N_O__DF]  DEFAULT ((0)) FOR [R_E_C_N_O_]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_R_E_C_D_E_L__DF]  DEFAULT ((0)) FOR [R_E_C_D_E_L_]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_X_CDANT_DF]  DEFAULT ('      ') FOR [A2_X_CDANT]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CODSIAF_DF]  DEFAULT ('    ') FOR [A2_CODSIAF]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_PRSTSER_DF]  DEFAULT (' ') FOR [A2_PRSTSER]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_SIMPNAC_DF]  DEFAULT (' ') FOR [A2_SIMPNAC]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_INSCMU_DF]  DEFAULT (' ') FOR [A2_INSCMU]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_ENDNOT_DF]  DEFAULT (' ') FOR [A2_ENDNOT]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_X_DTINC_DF]  DEFAULT ('        ') FOR [A2_X_DTINC]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_X_HRINC_DF]  DEFAULT ('        ') FOR [A2_X_HRINC]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_X_USINC_DF]  DEFAULT ('                    ') FOR [A2_X_USINC]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_X_DPC_DF]  DEFAULT ((0)) FOR [A2_X_DPC]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_X_CDPRO_DF]  DEFAULT (' ') FOR [A2_X_CDPRO]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2__BLQREC_DF]  DEFAULT (' ') FOR [A2__BLQREC]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_X_VALID_DF]  DEFAULT ('        ') FOR [A2_X_VALID]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_IRPROG_DF]  DEFAULT (' ') FOR [A2_IRPROG]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_RFACS_DF]  DEFAULT (' ') FOR [A2_RFACS]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_RFABOV_DF]  DEFAULT (' ') FOR [A2_RFABOV]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_INCULT_DF]  DEFAULT (' ') FOR [A2_INCULT]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CONTPRE_DF]  DEFAULT (' ') FOR [A2_CONTPRE]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CGCEX_DF]  DEFAULT ('              ') FOR [A2_CGCEX]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_NEMPR_DF]  DEFAULT ('                                                                                                                                                      ') FOR [A2_NEMPR]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_TPCON_DF]  DEFAULT ('  ') FOR [A2_TPCON]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_DTINIR_DF]  DEFAULT ('        ') FOR [A2_DTINIR]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_DTFIMR_DF]  DEFAULT ('        ') FOR [A2_DTFIMR]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_PAISEX_DF]  DEFAULT ('   ') FOR [A2_PAISEX]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_NIFEX_DF]  DEFAULT ('                              ') FOR [A2_NIFEX]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_LOGEX_DF]  DEFAULT ('                                                            ') FOR [A2_LOGEX]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_NUMEX_DF]  DEFAULT ('      ') FOR [A2_NUMEX]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_COMPLR_DF]  DEFAULT ('                         ') FOR [A2_COMPLR]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_BAIEX_DF]  DEFAULT ('                    ') FOR [A2_BAIEX]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_POSEX_DF]  DEFAULT ('          ') FOR [A2_POSEX]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CIDEX_DF]  DEFAULT ('                                        ') FOR [A2_CIDEX]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_ESTEX_DF]  DEFAULT ('                                        ') FOR [A2_ESTEX]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_TELRE_DF]  DEFAULT ('               ') FOR [A2_TELRE]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_BREEX_DF]  DEFAULT ('   ') FOR [A2_BREEX]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_TPREX_DF]  DEFAULT ('   ') FOR [A2_TPREX]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_TRBEX_DF]  DEFAULT ('  ') FOR [A2_TRBEX]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CPFIRP_DF]  DEFAULT ('           ') FOR [A2_CPFIRP]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_MINIRF_DF]  DEFAULT (' ') FOR [A2_MINIRF]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_REGESIM_DF]  DEFAULT (' ') FOR [A2_REGESIM]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_INCLTMG_DF]  DEFAULT (' ') FOR [A2_INCLTMG]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_X_LIMCO_DF]  DEFAULT ((0)) FOR [A2_X_LIMCO]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_X_JAN_DF]  DEFAULT ((0)) FOR [A2_X_JAN]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_X_FEV_DF]  DEFAULT ((0)) FOR [A2_X_FEV]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_X_MAR_DF]  DEFAULT ((0)) FOR [A2_X_MAR]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_X_ABR_DF]  DEFAULT ((0)) FOR [A2_X_ABR]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_X_MAI_DF]  DEFAULT ((0)) FOR [A2_X_MAI]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_X_JUN_DF]  DEFAULT ((0)) FOR [A2_X_JUN]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_X_JUL_DF]  DEFAULT ((0)) FOR [A2_X_JUL]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_X_AGO_DF]  DEFAULT ((0)) FOR [A2_X_AGO]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_X_SET_DF]  DEFAULT ((0)) FOR [A2_X_SET]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_X_OUT_DF]  DEFAULT ((0)) FOR [A2_X_OUT]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_X_NOV_DF]  DEFAULT ((0)) FOR [A2_X_NOV]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_X_DEZ_DF]  DEFAULT ((0)) FOR [A2_X_DEZ]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_TRIBFAV_DF]  DEFAULT (' ') FOR [A2_TRIBFAV]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CPOMSP_DF]  DEFAULT (' ') FOR [A2_CPOMSP]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_TPLOGR_DF]  DEFAULT ('   ') FOR [A2_TPLOGR]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_SITESBH_DF]  DEFAULT (' ') FOR [A2_SITESBH]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_TPJ_DF]  DEFAULT (' ') FOR [A2_TPJ]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_FILTRF_DF]  DEFAULT ('  ') FOR [A2_FILTRF]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_APOLICE_DF]  DEFAULT ('               ') FOR [A2_APOLICE]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_LOCQUIT_DF]  DEFAULT (' ') FOR [A2_LOCQUIT]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_STRNTRC_DF]  DEFAULT (' ') FOR [A2_STRNTRC]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_RNTRC_DF]  DEFAULT ('              ') FOR [A2_RNTRC]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_DTRNTRC_DF]  DEFAULT ('        ') FOR [A2_DTRNTRC]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_TPRNTRC_DF]  DEFAULT (' ') FOR [A2_TPRNTRC]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_EQPTAC_DF]  DEFAULT (' ') FOR [A2_EQPTAC]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_TPCONTA_DF]  DEFAULT (' ') FOR [A2_TPCONTA]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_IBGE_DF]  DEFAULT ('           ') FOR [A2_IBGE]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CODADM_DF]  DEFAULT ('   ') FOR [A2_CODADM]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_IMPIP_DF]  DEFAULT (' ') FOR [A2_IMPIP]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_MJURIDI_DF]  DEFAULT (' ') FOR [A2_MJURIDI]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CONFFIS_DF]  DEFAULT (' ') FOR [A2_CONFFIS]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_MUNSC_DF]  DEFAULT ('     ') FOR [A2_MUNSC]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_X_TIPO_DF]  DEFAULT (' ') FOR [A2_X_TIPO]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_X_REPOR_DF]  DEFAULT ((0)) FOR [A2_X_REPOR]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CCICMS_DF]  DEFAULT (' ') FOR [A2_CCICMS]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_RESPTRI_DF]  DEFAULT ('  ') FOR [A2_RESPTRI]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_RECFMD_DF]  DEFAULT (' ') FOR [A2_RECFMD]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_RETISI_DF]  DEFAULT (' ') FOR [A2_RETISI]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_ISICM_DF]  DEFAULT (' ') FOR [A2_ISICM]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_IDHIST_DF]  DEFAULT ('                    ') FOR [A2_IDHIST]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_TIPCTA_DF]  DEFAULT (' ') FOR [A2_TIPCTA]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_X_PRAZO_DF]  DEFAULT ((0)) FOR [A2_X_PRAZO]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_INOVAUT_DF]  DEFAULT (' ') FOR [A2_INOVAUT]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_DTCONV_DF]  DEFAULT ('        ') FOR [A2_DTCONV]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_NOMRESP_DF]  DEFAULT ('                                             ') FOR [A2_NOMRESP]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CARGO_DF]  DEFAULT ('                                        ') FOR [A2_CARGO]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_RFUNDES_DF]  DEFAULT (' ') FOR [A2_RFUNDES]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_RIMAMT_DF]  DEFAULT (' ') FOR [A2_RIMAMT]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_RFASEMT_DF]  DEFAULT (' ') FOR [A2_RFASEMT]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_MINPUB_DF]  DEFAULT (' ') FOR [A2_MINPUB]
GO
ALTER TABLE [dbo].[SA2010] ADD  CONSTRAINT [SA2010_A2_CALCINP_DF]  DEFAULT (' ') FOR [A2_CALCINP]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_FILIAL_DF]  DEFAULT ('  ') FOR [A3_FILIAL]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_COD_DF]  DEFAULT ('      ') FOR [A3_COD]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_NOME_DF]  DEFAULT ('                                        ') FOR [A3_NOME]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_NREDUZ_DF]  DEFAULT ('                         ') FOR [A3_NREDUZ]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_END_DF]  DEFAULT ('                                        ') FOR [A3_END]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_BAIRRO_DF]  DEFAULT ('                    ') FOR [A3_BAIRRO]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_MUN_DF]  DEFAULT ('               ') FOR [A3_MUN]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_EST_DF]  DEFAULT ('  ') FOR [A3_EST]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_CEP_DF]  DEFAULT ('        ') FOR [A3_CEP]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_DDDTEL_DF]  DEFAULT ('   ') FOR [A3_DDDTEL]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_TEL_DF]  DEFAULT ('               ') FOR [A3_TEL]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_FAX_DF]  DEFAULT ('               ') FOR [A3_FAX]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_TELEX_DF]  DEFAULT ('          ') FOR [A3_TELEX]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_TIPO_DF]  DEFAULT (' ') FOR [A3_TIPO]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_CGC_DF]  DEFAULT ('              ') FOR [A3_CGC]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_INSCR_DF]  DEFAULT ('                  ') FOR [A3_INSCR]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_INSCRM_DF]  DEFAULT ('                  ') FOR [A3_INSCRM]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_EMAIL_DF]  DEFAULT ('                                                                                ') FOR [A3_EMAIL]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_HPAGE_DF]  DEFAULT ('                              ') FOR [A3_HPAGE]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_CODUSR_DF]  DEFAULT ('      ') FOR [A3_CODUSR]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_SUPER_DF]  DEFAULT ('      ') FOR [A3_SUPER]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_GEREN_DF]  DEFAULT ('      ') FOR [A3_GEREN]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_FORNECE_DF]  DEFAULT ('      ') FOR [A3_FORNECE]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_LOJA_DF]  DEFAULT ('  ') FOR [A3_LOJA]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_GERASE2_DF]  DEFAULT (' ') FOR [A3_GERASE2]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_BCO1_DF]  DEFAULT ('   ') FOR [A3_BCO1]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_REGIAO_DF]  DEFAULT ('   ') FOR [A3_REGIAO]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_COMIS_DF]  DEFAULT ((0)) FOR [A3_COMIS]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_ALEMISS_DF]  DEFAULT ((0)) FOR [A3_ALEMISS]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_ALBAIXA_DF]  DEFAULT ((0)) FOR [A3_ALBAIXA]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_ICM_DF]  DEFAULT (' ') FOR [A3_ICM]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_ICMSRET_DF]  DEFAULT (' ') FOR [A3_ICMSRET]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_ISS_DF]  DEFAULT (' ') FOR [A3_ISS]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_IPI_DF]  DEFAULT (' ') FOR [A3_IPI]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_FRETE_DF]  DEFAULT (' ') FOR [A3_FRETE]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_ACREFIN_DF]  DEFAULT (' ') FOR [A3_ACREFIN]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_DIA_DF]  DEFAULT ((0)) FOR [A3_DIA]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_DDD_DF]  DEFAULT (' ') FOR [A3_DDD]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_PERDESC_DF]  DEFAULT ((0)) FOR [A3_PERDESC]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_TIPSUP_DF]  DEFAULT ('   ') FOR [A3_TIPSUP]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_DIARESE_DF]  DEFAULT ((0)) FOR [A3_DIARESE]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_SENHA_DF]  DEFAULT ('      ') FOR [A3_SENHA]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_UNIDAD_DF]  DEFAULT ('      ') FOR [A3_UNIDAD]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_HAND_DF]  DEFAULT (' ') FOR [A3_HAND]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_PEDINI_DF]  DEFAULT ('      ') FOR [A3_PEDINI]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_QTCONTA_DF]  DEFAULT ((0)) FOR [A3_QTCONTA]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_PEDFIM_DF]  DEFAULT ('      ') FOR [A3_PEDFIM]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_CLIINI_DF]  DEFAULT ('      ') FOR [A3_CLIINI]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_REGSLA_DF]  DEFAULT ('      ') FOR [A3_REGSLA]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_CLIFIM_DF]  DEFAULT ('      ') FOR [A3_CLIFIM]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_CARGO_DF]  DEFAULT ('      ') FOR [A3_CARGO]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_PROXPED_DF]  DEFAULT ('      ') FOR [A3_PROXPED]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_PROXCLI_DF]  DEFAULT ('      ') FOR [A3_PROXCLI]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_GRPREP_DF]  DEFAULT ('      ') FOR [A3_GRPREP]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_FAT_RH_DF]  DEFAULT ('  ') FOR [A3_FAT_RH]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_GRUPSAN_DF]  DEFAULT ('      ') FOR [A3_GRUPSAN]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_DEPEND_DF]  DEFAULT ('  ') FOR [A3_DEPEND]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_PEN_ALI_DF]  DEFAULT ((0)) FOR [A3_PEN_ALI]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_TIPVEND_DF]  DEFAULT (' ') FOR [A3_TIPVEND]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_NUMRA_DF]  DEFAULT ('      ') FOR [A3_NUMRA]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_URLEXG_DF]  DEFAULT ('                                                  ') FOR [A3_URLEXG]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_PAIS_DF]  DEFAULT ('   ') FOR [A3_PAIS]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_DDI_DF]  DEFAULT ('      ') FOR [A3_DDI]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_CEL_DF]  DEFAULT ('               ') FOR [A3_CEL]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_ADMISS_DF]  DEFAULT ('        ') FOR [A3_ADMISS]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_D_E_L_E_T__DF]  DEFAULT (' ') FOR [D_E_L_E_T_]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_R_E_C_N_O__DF]  DEFAULT ((0)) FOR [R_E_C_N_O_]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_R_E_C_D_E_L__DF]  DEFAULT ((0)) FOR [R_E_C_D_E_L_]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_X_CODMU_DF]  DEFAULT ('     ') FOR [A3_X_CODMU]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_X_PESS_DF]  DEFAULT (' ') FOR [A3_X_PESS]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_X_RG_DF]  DEFAULT ('                  ') FOR [A3_X_RG]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_X_FPGTO_DF]  DEFAULT ('   ') FOR [A3_X_FPGTO]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_X_TIPO_DF]  DEFAULT (' ') FOR [A3_X_TIPO]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_MSBLQL_DF]  DEFAULT (' ') FOR [A3_MSBLQL]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_X_SALDO_DF]  DEFAULT ((0)) FOR [A3_X_SALDO]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_X_SUPER_DF]  DEFAULT ('      ') FOR [A3_X_SUPER]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_X_PMAX_DF]  DEFAULT ((0)) FOR [A3_X_PMAX]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_NVLSTR_DF]  DEFAULT ('                              ') FOR [A3_NVLSTR]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_NIVEL_DF]  DEFAULT ((0)) FOR [A3_NIVEL]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_LANEXG_DF]  DEFAULT ('     ') FOR [A3_LANEXG]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_X_WORK1_DF]  DEFAULT (' ') FOR [A3_X_WORK1]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_X_WORK2_DF]  DEFAULT (' ') FOR [A3_X_WORK2]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_SINCTAF_DF]  DEFAULT (' ') FOR [A3_SINCTAF]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_SINCAGE_DF]  DEFAULT (' ') FOR [A3_SINCAGE]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_SINCCON_DF]  DEFAULT (' ') FOR [A3_SINCCON]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_PERAGE_DF]  DEFAULT (' ') FOR [A3_PERAGE]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_PERTAF_DF]  DEFAULT (' ') FOR [A3_PERTAF]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_TIMEMIN_DF]  DEFAULT ('    ') FOR [A3_TIMEMIN]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_USUCORP_DF]  DEFAULT ('                              ') FOR [A3_USUCORP]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_HABSINC_DF]  DEFAULT (' ') FOR [A3_HABSINC]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_PISCOF_DF]  DEFAULT (' ') FOR [A3_PISCOF]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_BASEIR_DF]  DEFAULT (' ') FOR [A3_BASEIR]
GO
ALTER TABLE [dbo].[SA3010] ADD  CONSTRAINT [SA3010_A3_CODISS_DF]  DEFAULT ('      ') FOR [A3_CODISS]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_FILIAL_DF]  DEFAULT ('  ') FOR [A4_FILIAL]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_COD_DF]  DEFAULT ('      ') FOR [A4_COD]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_NOME_DF]  DEFAULT ('                                        ') FOR [A4_NOME]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_NREDUZ_DF]  DEFAULT ('               ') FOR [A4_NREDUZ]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_VIA_DF]  DEFAULT ('               ') FOR [A4_VIA]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_END_DF]  DEFAULT ('                                        ') FOR [A4_END]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_BAIRRO_DF]  DEFAULT ('                              ') FOR [A4_BAIRRO]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_MUN_DF]  DEFAULT ('               ') FOR [A4_MUN]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_EST_DF]  DEFAULT ('  ') FOR [A4_EST]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_CEP_DF]  DEFAULT ('        ') FOR [A4_CEP]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_DDI_DF]  DEFAULT ('      ') FOR [A4_DDI]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_DDD_DF]  DEFAULT ('   ') FOR [A4_DDD]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_TEL_DF]  DEFAULT ('               ') FOR [A4_TEL]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_CGC_DF]  DEFAULT ('              ') FOR [A4_CGC]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_TELEX_DF]  DEFAULT ('          ') FOR [A4_TELEX]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_INSEST_DF]  DEFAULT ('               ') FOR [A4_INSEST]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_EMAIL_DF]  DEFAULT ('                                                            ') FOR [A4_EMAIL]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_HPAGE_DF]  DEFAULT ('                              ') FOR [A4_HPAGE]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_CONTATO_DF]  DEFAULT ('               ') FOR [A4_CONTATO]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_ESTFIS_DF]  DEFAULT ('      ') FOR [A4_ESTFIS]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_ENDPAD_DF]  DEFAULT ('               ') FOR [A4_ENDPAD]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_LOCAL_DF]  DEFAULT ('  ') FOR [A4_LOCAL]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_RATFRE_DF]  DEFAULT (' ') FOR [A4_RATFRE]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_COMPLEM_DF]  DEFAULT ('                                                  ') FOR [A4_COMPLEM]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_COD_MUN_DF]  DEFAULT ('         ') FOR [A4_COD_MUN]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_FOMEZER_DF]  DEFAULT (' ') FOR [A4_FOMEZER]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_SUFRAMA_DF]  DEFAULT ('            ') FOR [A4_SUFRAMA]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_CODPAIS_DF]  DEFAULT ('     ') FOR [A4_CODPAIS]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_TPTRANS_DF]  DEFAULT (' ') FOR [A4_TPTRANS]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_D_E_L_E_T__DF]  DEFAULT (' ') FOR [D_E_L_E_T_]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_R_E_C_N_O__DF]  DEFAULT ((0)) FOR [R_E_C_N_O_]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_R_E_C_D_E_L__DF]  DEFAULT ((0)) FOR [R_E_C_D_E_L_]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_ENDNOT_DF]  DEFAULT (' ') FOR [A4_ENDNOT]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_COLIG_DF]  DEFAULT (' ') FOR [A4_COLIG]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_IDETIQ_DF]  DEFAULT ('          ') FOR [A4_IDETIQ]
GO
ALTER TABLE [dbo].[SA4010] ADD  CONSTRAINT [SA4010_A4_X_ATIV_DF]  DEFAULT (' ') FOR [A4_X_ATIV]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PARCEI_DF]  DEFAULT ('      ') FOR [B1_PARCEI]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_FILIAL_DF]  DEFAULT ('  ') FOR [B1_FILIAL]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_COD_DF]  DEFAULT ('               ') FOR [B1_COD]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_TIPO_DF]  DEFAULT ('  ') FOR [B1_TIPO]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CODITE_DF]  DEFAULT ('                           ') FOR [B1_CODITE]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_UM_DF]  DEFAULT ('  ') FOR [B1_UM]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_LOCPAD_DF]  DEFAULT ('  ') FOR [B1_LOCPAD]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_GRUPO_DF]  DEFAULT ('    ') FOR [B1_GRUPO]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PICM_DF]  DEFAULT ((0)) FOR [B1_PICM]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_IPI_DF]  DEFAULT ((0)) FOR [B1_IPI]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_POSIPI_DF]  DEFAULT ('          ') FOR [B1_POSIPI]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_EX_NCM_DF]  DEFAULT ('   ') FOR [B1_EX_NCM]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_EX_NBM_DF]  DEFAULT ('   ') FOR [B1_EX_NBM]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_ALIQISS_DF]  DEFAULT ((0)) FOR [B1_ALIQISS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CODISS_DF]  DEFAULT ('         ') FOR [B1_CODISS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_MSBLQL_DF]  DEFAULT (' ') FOR [B1_MSBLQL]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_TE_DF]  DEFAULT ('   ') FOR [B1_TE]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_TS_DF]  DEFAULT ('   ') FOR [B1_TS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PICMRET_DF]  DEFAULT ((0)) FOR [B1_PICMRET]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PICMENT_DF]  DEFAULT ((0)) FOR [B1_PICMENT]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_IMPZFRC_DF]  DEFAULT (' ') FOR [B1_IMPZFRC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_BITMAP_DF]  DEFAULT ('                    ') FOR [B1_BITMAP]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_SEGUM_DF]  DEFAULT ('  ') FOR [B1_SEGUM]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CONV_DF]  DEFAULT ((0)) FOR [B1_CONV]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_TIPCONV_DF]  DEFAULT (' ') FOR [B1_TIPCONV]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_ALTER_DF]  DEFAULT ('               ') FOR [B1_ALTER]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_QE_DF]  DEFAULT ((0)) FOR [B1_QE]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PRV1_DF]  DEFAULT ((0)) FOR [B1_PRV1]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_EMIN_DF]  DEFAULT ((0)) FOR [B1_EMIN]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CUSTD_DF]  DEFAULT ((0)) FOR [B1_CUSTD]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_UCALSTD_DF]  DEFAULT ('        ') FOR [B1_UCALSTD]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_UPRC_DF]  DEFAULT ((0)) FOR [B1_UPRC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_MCUSTD_DF]  DEFAULT (' ') FOR [B1_MCUSTD]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_UCOM_DF]  DEFAULT ('        ') FOR [B1_UCOM]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PESO_DF]  DEFAULT ((0)) FOR [B1_PESO]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_ESTSEG_DF]  DEFAULT ((0)) FOR [B1_ESTSEG]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_ESTFOR_DF]  DEFAULT ('   ') FOR [B1_ESTFOR]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_FORPRZ_DF]  DEFAULT ('   ') FOR [B1_FORPRZ]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PE_DF]  DEFAULT ((0)) FOR [B1_PE]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_TIPE_DF]  DEFAULT (' ') FOR [B1_TIPE]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_LE_DF]  DEFAULT ((0)) FOR [B1_LE]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_LM_DF]  DEFAULT ((0)) FOR [B1_LM]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CONTA_DF]  DEFAULT ('                    ') FOR [B1_CONTA]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_TOLER_DF]  DEFAULT ((0)) FOR [B1_TOLER]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CC_DF]  DEFAULT ('         ') FOR [B1_CC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_ITEMCC_DF]  DEFAULT ('           ') FOR [B1_ITEMCC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_FAMILIA_DF]  DEFAULT (' ') FOR [B1_FAMILIA]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PROC_DF]  DEFAULT ('      ') FOR [B1_PROC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_QB_DF]  DEFAULT ((0)) FOR [B1_QB]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_LOJPROC_DF]  DEFAULT ('  ') FOR [B1_LOJPROC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_APROPRI_DF]  DEFAULT (' ') FOR [B1_APROPRI]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_TIPODEC_DF]  DEFAULT (' ') FOR [B1_TIPODEC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_ORIGEM_DF]  DEFAULT (' ') FOR [B1_ORIGEM]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CLASFIS_DF]  DEFAULT ('  ') FOR [B1_CLASFIS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_FANTASM_DF]  DEFAULT (' ') FOR [B1_FANTASM]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_RASTRO_DF]  DEFAULT (' ') FOR [B1_RASTRO]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_UREV_DF]  DEFAULT ('        ') FOR [B1_UREV]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_DATREF_DF]  DEFAULT ('        ') FOR [B1_DATREF]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_FORAEST_DF]  DEFAULT (' ') FOR [B1_FORAEST]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_COMIS_DF]  DEFAULT ((0)) FOR [B1_COMIS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_MONO_DF]  DEFAULT (' ') FOR [B1_MONO]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PERINV_DF]  DEFAULT ((0)) FOR [B1_PERINV]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_DTREFP1_DF]  DEFAULT ('        ') FOR [B1_DTREFP1]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_GRTRIB_DF]  DEFAULT ('      ') FOR [B1_GRTRIB]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_MRP_DF]  DEFAULT (' ') FOR [B1_MRP]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_NOTAMIN_DF]  DEFAULT ((0)) FOR [B1_NOTAMIN]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PRVALID_DF]  DEFAULT ((0)) FOR [B1_PRVALID]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_NUMCOP_DF]  DEFAULT ((0)) FOR [B1_NUMCOP]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CONINI_DF]  DEFAULT ('        ') FOR [B1_CONINI]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CONTSOC_DF]  DEFAULT (' ') FOR [B1_CONTSOC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_IRRF_DF]  DEFAULT (' ') FOR [B1_IRRF]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CODBAR_DF]  DEFAULT ('               ') FOR [B1_CODBAR]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_GRADE_DF]  DEFAULT (' ') FOR [B1_GRADE]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_FORMLOT_DF]  DEFAULT ('   ') FOR [B1_FORMLOT]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_LOCALIZ_DF]  DEFAULT (' ') FOR [B1_LOCALIZ]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_FPCOD_DF]  DEFAULT ('  ') FOR [B1_FPCOD]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_OPERPAD_DF]  DEFAULT ('  ') FOR [B1_OPERPAD]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CONTRAT_DF]  DEFAULT (' ') FOR [B1_CONTRAT]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_DESC_P_DF]  DEFAULT ('      ') FOR [B1_DESC_P]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_DESC_GI_DF]  DEFAULT ('      ') FOR [B1_DESC_GI]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_DESC_I_DF]  DEFAULT ('      ') FOR [B1_DESC_I]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_VLREFUS_DF]  DEFAULT ((0)) FOR [B1_VLREFUS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_IMPORT_DF]  DEFAULT (' ') FOR [B1_IMPORT]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_OPC_DF]  DEFAULT ('                                                                                ') FOR [B1_OPC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_ANUENTE_DF]  DEFAULT (' ') FOR [B1_ANUENTE]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CODOBS_DF]  DEFAULT ('      ') FOR [B1_CODOBS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_SITPROD_DF]  DEFAULT ('  ') FOR [B1_SITPROD]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_FABRIC_DF]  DEFAULT ('                    ') FOR [B1_FABRIC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_MODELO_DF]  DEFAULT ('                              ') FOR [B1_MODELO]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_SETOR_DF]  DEFAULT ('  ') FOR [B1_SETOR]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_BALANCA_DF]  DEFAULT (' ') FOR [B1_BALANCA]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_TECLA_DF]  DEFAULT ('   ') FOR [B1_TECLA]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PRODPAI_DF]  DEFAULT ('               ') FOR [B1_PRODPAI]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_TIPOCQ_DF]  DEFAULT (' ') FOR [B1_TIPOCQ]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_SOLICIT_DF]  DEFAULT (' ') FOR [B1_SOLICIT]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_QUADPRO_DF]  DEFAULT (' ') FOR [B1_QUADPRO]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_AGREGCU_DF]  DEFAULT (' ') FOR [B1_AGREGCU]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_GRUPCOM_DF]  DEFAULT ('      ') FOR [B1_GRUPCOM]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_DESPIMP_DF]  DEFAULT (' ') FOR [B1_DESPIMP]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_NUMCQPR_DF]  DEFAULT ((0)) FOR [B1_NUMCQPR]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CONTCQP_DF]  DEFAULT ((0)) FOR [B1_CONTCQP]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_REVATU_DF]  DEFAULT ('   ') FOR [B1_REVATU]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_INSS_DF]  DEFAULT (' ') FOR [B1_INSS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CODEMB_DF]  DEFAULT ('                    ') FOR [B1_CODEMB]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_ESPECIF_DF]  DEFAULT ('                                                                                ') FOR [B1_ESPECIF]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_MAT_PRI_DF]  DEFAULT ('                    ') FOR [B1_MAT_PRI]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_REDINSS_DF]  DEFAULT ((0)) FOR [B1_REDINSS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_NALNCCA_DF]  DEFAULT ('       ') FOR [B1_NALNCCA]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_REDIRRF_DF]  DEFAULT ((0)) FOR [B1_REDIRRF]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_ALADI_DF]  DEFAULT ('   ') FOR [B1_ALADI]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_NALSH_DF]  DEFAULT ('        ') FOR [B1_NALSH]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_TAB_IPI_DF]  DEFAULT ('  ') FOR [B1_TAB_IPI]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_GRUDES_DF]  DEFAULT ('   ') FOR [B1_GRUDES]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_REDPIS_DF]  DEFAULT ((0)) FOR [B1_REDPIS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_REDCOF_DF]  DEFAULT ((0)) FOR [B1_REDCOF]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_DATASUB_DF]  DEFAULT ('        ') FOR [B1_DATASUB]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PCSLL_DF]  DEFAULT ((0)) FOR [B1_PCSLL]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PCOFINS_DF]  DEFAULT ((0)) FOR [B1_PCOFINS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PPIS_DF]  DEFAULT ((0)) FOR [B1_PPIS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_MTBF_DF]  DEFAULT ((0)) FOR [B1_MTBF]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_MTTR_DF]  DEFAULT ((0)) FOR [B1_MTTR]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_FLAGSUG_DF]  DEFAULT (' ') FOR [B1_FLAGSUG]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CLASSVE_DF]  DEFAULT (' ') FOR [B1_CLASSVE]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_MIDIA_DF]  DEFAULT (' ') FOR [B1_MIDIA]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_QTMIDIA_DF]  DEFAULT ((0)) FOR [B1_QTMIDIA]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_VLR_IPI_DF]  DEFAULT ((0)) FOR [B1_VLR_IPI]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_ENVOBR_DF]  DEFAULT (' ') FOR [B1_ENVOBR]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_QTDSER_DF]  DEFAULT ((0)) FOR [B1_QTDSER]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_SERIE_DF]  DEFAULT ('                    ') FOR [B1_SERIE]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_FAIXAS_DF]  DEFAULT ((0)) FOR [B1_FAIXAS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_NROPAG_DF]  DEFAULT ((0)) FOR [B1_NROPAG]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_ISBN_DF]  DEFAULT ('          ') FOR [B1_ISBN]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_TITORIG_DF]  DEFAULT ('                                                  ') FOR [B1_TITORIG]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_LINGUA_DF]  DEFAULT ('                    ') FOR [B1_LINGUA]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_EDICAO_DF]  DEFAULT ('   ') FOR [B1_EDICAO]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_OBSISBN_DF]  DEFAULT ('                                        ') FOR [B1_OBSISBN]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CLVL_DF]  DEFAULT ('                    ') FOR [B1_CLVL]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_ATIVO_DF]  DEFAULT (' ') FOR [B1_ATIVO]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_EMAX_DF]  DEFAULT ((0)) FOR [B1_EMAX]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PESBRU_DF]  DEFAULT ((0)) FOR [B1_PESBRU]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_TIPCAR_DF]  DEFAULT ('      ') FOR [B1_TIPCAR]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_FRACPER_DF]  DEFAULT ((0)) FOR [B1_FRACPER]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_INT_ICM_DF]  DEFAULT ((0)) FOR [B1_INT_ICM]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_VLR_ICM_DF]  DEFAULT ((0)) FOR [B1_VLR_ICM]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_VLRSELO_DF]  DEFAULT ((0)) FOR [B1_VLRSELO]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CODNOR_DF]  DEFAULT ('   ') FOR [B1_CODNOR]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CORPRI_DF]  DEFAULT ('      ') FOR [B1_CORPRI]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CORSEC_DF]  DEFAULT ('      ') FOR [B1_CORSEC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_NICONE_DF]  DEFAULT ('               ') FOR [B1_NICONE]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_ATRIB1_DF]  DEFAULT ('      ') FOR [B1_ATRIB1]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_ATRIB2_DF]  DEFAULT ('      ') FOR [B1_ATRIB2]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_ATRIB3_DF]  DEFAULT ('      ') FOR [B1_ATRIB3]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_REGSEQ_DF]  DEFAULT ('      ') FOR [B1_REGSEQ]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CPOTENC_DF]  DEFAULT (' ') FOR [B1_CPOTENC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_POTENCI_DF]  DEFAULT ((0)) FOR [B1_POTENCI]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_QTDACUM_DF]  DEFAULT ((0)) FOR [B1_QTDACUM]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_QTDINIC_DF]  DEFAULT ((0)) FOR [B1_QTDINIC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_REQUIS_DF]  DEFAULT (' ') FOR [B1_REQUIS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_SELO_DF]  DEFAULT (' ') FOR [B1_SELO]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_LOTVEN_DF]  DEFAULT ((0)) FOR [B1_LOTVEN]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_OK_DF]  DEFAULT ('    ') FOR [B1_OK]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_USAFEFO_DF]  DEFAULT (' ') FOR [B1_USAFEFO]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_GCCUSTO_DF]  DEFAULT ('        ') FOR [B1_GCCUSTO]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CCCUSTO_DF]  DEFAULT ('         ') FOR [B1_CCCUSTO]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CLASSE_DF]  DEFAULT ('      ') FOR [B1_CLASSE]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PMACNUT_DF]  DEFAULT ((0)) FOR [B1_PMACNUT]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PMICNUT_DF]  DEFAULT ((0)) FOR [B1_PMICNUT]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CODQAD_DF]  DEFAULT ('             ') FOR [B1_CODQAD]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_QBP_DF]  DEFAULT ((0)) FOR [B1_QBP]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PIS_DF]  DEFAULT (' ') FOR [B1_PIS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_VLR_PIS_DF]  DEFAULT ((0)) FOR [B1_VLR_PIS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_UMOEC_DF]  DEFAULT ((0)) FOR [B1_UMOEC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_UVLRC_DF]  DEFAULT ((0)) FOR [B1_UVLRC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_RETOPER_DF]  DEFAULT (' ') FOR [B1_RETOPER]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CNAE_DF]  DEFAULT ('         ') FOR [B1_CNAE]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CRDEST_DF]  DEFAULT ((0)) FOR [B1_CRDEST]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_COFINS_DF]  DEFAULT (' ') FOR [B1_COFINS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CSLL_DF]  DEFAULT (' ') FOR [B1_CSLL]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PRFDSUL_DF]  DEFAULT ((0)) FOR [B1_PRFDSUL]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CODANT_DF]  DEFAULT ('               ') FOR [B1_CODANT]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_FETHAB_DF]  DEFAULT (' ') FOR [B1_FETHAB]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_FRETISS_DF]  DEFAULT (' ') FOR [B1_FRETISS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CALCFET_DF]  DEFAULT (' ') FOR [B1_CALCFET]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PAUTFET_DF]  DEFAULT ((0)) FOR [B1_PAUTFET]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_VLR_COF_DF]  DEFAULT ((0)) FOR [B1_VLR_COF]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_D_E_L_E_T__DF]  DEFAULT (' ') FOR [D_E_L_E_T_]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_R_E_C_N_O__DF]  DEFAULT ((0)) FOR [R_E_C_N_O_]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_R_E_C_D_E_L__DF]  DEFAULT ((0)) FOR [R_E_C_D_E_L_]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PRODSBP_DF]  DEFAULT (' ') FOR [B1_PRODSBP]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_ESTRORI_DF]  DEFAULT ('               ') FOR [B1_ESTRORI]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_LOTESBP_DF]  DEFAULT ((0)) FOR [B1_LOTESBP]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_TPREG_DF]  DEFAULT (' ') FOR [B1_TPREG]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_IVAAJU_DF]  DEFAULT (' ') FOR [B1_IVAAJU]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_FUSTF_DF]  DEFAULT (' ') FOR [B1_FUSTF]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_REGRISS_DF]  DEFAULT ('  ') FOR [B1_REGRISS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_ESCRIPI_DF]  DEFAULT (' ') FOR [B1_ESCRIPI]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_FECP_DF]  DEFAULT ((0)) FOR [B1_FECP]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_MARKU_DF]  DEFAULT ((0)) FOR [B1_X_MARKU]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_REFER_DF]  DEFAULT ('          ') FOR [B1_X_REFER]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_ANVIS_DF]  DEFAULT ('               ') FOR [B1_X_ANVIS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_DESC_DF]  DEFAULT ('                                                  ') FOR [B1_DESC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_PROMO_DF]  DEFAULT (' ') FOR [B1_X_PROMO]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_ULICM_DF]  DEFAULT ((0)) FOR [B1_X_ULICM]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_ULIPI_DF]  DEFAULT ((0)) FOR [B1_X_ULIPI]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_ULIST_DF]  DEFAULT ((0)) FOR [B1_X_ULIST]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_CUSFI_DF]  DEFAULT ((0)) FOR [B1_X_CUSFI]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_ULDOC_DF]  DEFAULT ('         ') FOR [B1_X_ULDOC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_ULSER_DF]  DEFAULT ('   ') FOR [B1_X_ULSER]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_ULDAT_DF]  DEFAULT ('        ') FOR [B1_X_ULDAT]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_ULFOR_DF]  DEFAULT ('      ') FOR [B1_X_ULFOR]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_ULLOJ_DF]  DEFAULT ('  ') FOR [B1_X_ULLOJ]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_UPRC1_DF]  DEFAULT ((0)) FOR [B1_X_UPRC1]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_UPRC2_DF]  DEFAULT ((0)) FOR [B1_X_UPRC2]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_SET_DF]  DEFAULT ('    ') FOR [B1_X_SET]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_FLAG_DF]  DEFAULT (' ') FOR [B1_X_FLAG]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_DTINC_DF]  DEFAULT ('        ') FOR [B1_X_DTINC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_HRINC_DF]  DEFAULT ('        ') FOR [B1_X_HRINC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_USINC_DF]  DEFAULT ('                    ') FOR [B1_X_USINC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_RUA_DF]  DEFAULT ('  ') FOR [B1_X_RUA]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_IMETQ_DF]  DEFAULT (' ') FOR [B1_X_IMETQ]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_PISCO_DF]  DEFAULT (' ') FOR [B1_X_PISCO]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_CODL_DF]  DEFAULT (' ') FOR [B1_X_CODL]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_TSINT_DF]  DEFAULT ('   ') FOR [B1_X_TSINT]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_DTPRC_DF]  DEFAULT ('        ') FOR [B1_X_DTPRC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_HRPRC_DF]  DEFAULT ('        ') FOR [B1_X_HRPRC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_USPRC_DF]  DEFAULT ('                    ') FOR [B1_X_USPRC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_STPRC_DF]  DEFAULT (' ') FOR [B1_X_STPRC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_RTPRC_DF]  DEFAULT ('          ') FOR [B1_X_RTPRC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_TET_DF]  DEFAULT ('   ') FOR [B1_X_TET]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1__AVULSO_DF]  DEFAULT (' ') FOR [B1__AVULSO]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1__PRDSUP_DF]  DEFAULT ('               ') FOR [B1__PRDSUP]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1__MULAVU_DF]  DEFAULT ((0)) FOR [B1__MULAVU]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1__GRTRIB_DF]  DEFAULT ('      ') FOR [B1__GRTRIB]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1__BLQREC_DF]  DEFAULT (' ') FOR [B1__BLQREC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_SIMI_DF]  DEFAULT ((0)) FOR [B1_X_SIMI]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_FABRI_DF]  DEFAULT ('      ') FOR [B1_X_FABRI]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_ESTM_DF]  DEFAULT ((0)) FOR [B1_X_ESTM]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_RPRODEP_DF]  DEFAULT (' ') FOR [B1_RPRODEP]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_SELOEN_DF]  DEFAULT ('      ') FOR [B1_SELOEN]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_ALFECOP_DF]  DEFAULT ((0)) FOR [B1_ALFECOP]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_ALFECST_DF]  DEFAULT ((0)) FOR [B1_ALFECST]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_FECOP_DF]  DEFAULT (' ') FOR [B1_FECOP]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CRICMS_DF]  DEFAULT (' ') FOR [B1_CRICMS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PRODREC_DF]  DEFAULT (' ') FOR [B1_PRODREC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_TRIBMUN_DF]  DEFAULT ('                    ') FOR [B1_TRIBMUN]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_VIGENC_DF]  DEFAULT ('        ') FOR [B1_VIGENC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CRDPRES_DF]  DEFAULT ((0)) FOR [B1_CRDPRES]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_AFETHAB_DF]  DEFAULT ((0)) FOR [B1_AFETHAB]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_AFACS_DF]  DEFAULT ((0)) FOR [B1_AFACS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_AFABOV_DF]  DEFAULT ((0)) FOR [B1_AFABOV]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_TFETHAB_DF]  DEFAULT (' ') FOR [B1_TFETHAB]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_REFBAS_DF]  DEFAULT (' ') FOR [B1_REFBAS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_TPPROD_DF]  DEFAULT (' ') FOR [B1_TPPROD]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_VEREAN_DF]  DEFAULT ('  ') FOR [B1_VEREAN]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PRDORI_DF]  DEFAULT ('               ') FOR [B1_PRDORI]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_RICM65_DF]  DEFAULT (' ') FOR [B1_RICM65]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CFEM_DF]  DEFAULT (' ') FOR [B1_CFEM]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CFEMS_DF]  DEFAULT (' ') FOR [B1_CFEMS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CFEMA_DF]  DEFAULT ((0)) FOR [B1_CFEMA]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_FLGAV_DF]  DEFAULT (' ') FOR [B1_X_FLGAV]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_CONTA_DF]  DEFAULT ('                    ') FOR [B1_X_CONTA]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_GRPA_DF]  DEFAULT ('    ') FOR [B1_X_GRPA]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_SUBGR_DF]  DEFAULT ('    ') FOR [B1_X_SUBGR]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_TNATREC_DF]  DEFAULT ('    ') FOR [B1_TNATREC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CNATREC_DF]  DEFAULT ('   ') FOR [B1_CNATREC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_ALFUMAC_DF]  DEFAULT ((0)) FOR [B1_ALFUMAC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_DTCORTE_DF]  DEFAULT ('        ') FOR [B1_DTCORTE]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PRN944I_DF]  DEFAULT (' ') FOR [B1_PRN944I]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PR43080_DF]  DEFAULT ((0)) FOR [B1_PR43080]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CHASSI_DF]  DEFAULT ('                 ') FOR [B1_CHASSI]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CODLAN_DF]  DEFAULT ('      ') FOR [B1_CODLAN]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_CODF_DF]  DEFAULT ('                    ') FOR [B1_X_CODF]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_DESCF_DF]  DEFAULT ('                                                  ') FOR [B1_X_DESCF]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_DESCO_DF]  DEFAULT (' ') FOR [B1_X_DESCO]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_COMIS_DF]  DEFAULT ((0)) FOR [B1_X_COMIS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_GRPNATR_DF]  DEFAULT ('  ') FOR [B1_GRPNATR]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_DTFIMNT_DF]  DEFAULT ('        ') FOR [B1_DTFIMNT]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_FECPBA_DF]  DEFAULT ((0)) FOR [B1_FECPBA]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_DIFCNAE_DF]  DEFAULT ('           ') FOR [B1_DIFCNAE]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_DCI_DF]  DEFAULT (' ') FOR [B1_DCI]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_DCRE_DF]  DEFAULT ('          ') FOR [B1_DCRE]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_DCR_DF]  DEFAULT ('         ') FOR [B1_DCR]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_DCRII_DF]  DEFAULT ((0)) FOR [B1_DCRII]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_COEFDCR_DF]  DEFAULT ((0)) FOR [B1_COEFDCR]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PRINCMG_DF]  DEFAULT ((0)) FOR [B1_PRINCMG]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_OCUSF_DF]  DEFAULT ((0)) FOR [B1_X_OCUSF]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_WEB_DF]  DEFAULT ('                                    ') FOR [B1_X_WEB]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_REGESIM_DF]  DEFAULT (' ') FOR [B1_REGESIM]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_RSATIVO_DF]  DEFAULT (' ') FOR [B1_RSATIVO]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CRICMST_DF]  DEFAULT (' ') FOR [B1_CRICMST]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_ALFECRN_DF]  DEFAULT ((0)) FOR [B1_ALFECRN]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_PREDI_DF]  DEFAULT ('   ') FOR [B1_X_PREDI]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_PRATE_DF]  DEFAULT ('          ') FOR [B1_X_PRATE]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_ANDAR_DF]  DEFAULT ('          ') FOR [B1_X_ANDAR]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_TEDT_DF]  DEFAULT ('   ') FOR [B1_X_TEDT]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_ECOMM_DF]  DEFAULT (' ') FOR [B1_X_ECOMM]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_MEPLES_DF]  DEFAULT (' ') FOR [B1_MEPLES]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_AJUDIF_DF]  DEFAULT (' ') FOR [B1_AJUDIF]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_DESBSE3_DF]  DEFAULT ('                                                            ') FOR [B1_DESBSE3]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_BASE3_DF]  DEFAULT ('              ') FOR [B1_BASE3]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_IAT_DF]  DEFAULT (' ') FOR [B1_IAT]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_IPPT_DF]  DEFAULT (' ') FOR [B1_IPPT]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_SITTRIB_DF]  DEFAULT (' ') FOR [B1_SITTRIB]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_TALLA_DF]  DEFAULT ('      ') FOR [B1_TALLA]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CODPROC_DF]  DEFAULT ('      ') FOR [B1_CODPROC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_GDODIF_DF]  DEFAULT (' ') FOR [B1_GDODIF]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_VLCIF_DF]  DEFAULT ((0)) FOR [B1_VLCIF]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_MARKUP_DF]  DEFAULT ((0)) FOR [B1_MARKUP]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_VALEPRE_DF]  DEFAULT (' ') FOR [B1_VALEPRE]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_TIPOBN_DF]  DEFAULT ('  ') FOR [B1_TIPOBN]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_DESBSE2_DF]  DEFAULT ('                                                            ') FOR [B1_DESBSE2]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CARGAE_DF]  DEFAULT (' ') FOR [B1_CARGAE]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_ADMIN_DF]  DEFAULT ('          ') FOR [B1_ADMIN]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_BASE2_DF]  DEFAULT ('              ') FOR [B1_BASE2]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_GARANT_DF]  DEFAULT (' ') FOR [B1_GARANT]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_TIPVEC_DF]  DEFAULT ('      ') FOR [B1_TIPVEC]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_BASE_DF]  DEFAULT ('              ') FOR [B1_BASE]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PERGART_DF]  DEFAULT ((0)) FOR [B1_PERGART]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_COLOR_DF]  DEFAULT ('          ') FOR [B1_COLOR]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_ESPECIE_DF]  DEFAULT ('  ') FOR [B1_ESPECIE]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_TPDP_DF]  DEFAULT (' ') FOR [B1_TPDP]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_MNT_DF]  DEFAULT ('          ') FOR [B1_X_MNT]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_FRETA_DF]  DEFAULT ((0)) FOR [B1_X_FRETA]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_FRETV_DF]  DEFAULT ((0)) FOR [B1_X_FRETV]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_COMA_DF]  DEFAULT ((0)) FOR [B1_X_COMA]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_COMV_DF]  DEFAULT ((0)) FOR [B1_X_COMV]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_MRKPA_DF]  DEFAULT ((0)) FOR [B1_X_MRKPA]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_MRKPV_DF]  DEFAULT ((0)) FOR [B1_X_MRKPV]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_MRKMA_DF]  DEFAULT ((0)) FOR [B1_X_MRKMA]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_MRKMV_DF]  DEFAULT ((0)) FOR [B1_X_MRKMV]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_PSUG_DF]  DEFAULT ((0)) FOR [B1_X_PSUG]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PORCPRL_DF]  DEFAULT ('  ') FOR [B1_PORCPRL]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_AFAMAD_DF]  DEFAULT ((0)) FOR [B1_AFAMAD]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_IDHIST_DF]  DEFAULT ('                    ') FOR [B1_IDHIST]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_MSEXP_DF]  DEFAULT ('        ') FOR [B1_MSEXP]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_PAFMD5_DF]  DEFAULT ('                                ') FOR [B1_PAFMD5]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_MRKDA_DF]  DEFAULT ((0)) FOR [B1_X_MRKDA]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_MRKDV_DF]  DEFAULT ((0)) FOR [B1_X_MRKDV]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_X_ULCUS_DF]  DEFAULT ((0)) FOR [B1_X_ULCUS]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_GRPTI_DF]  DEFAULT ('    ') FOR [B1_GRPTI]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_GRPCST_DF]  DEFAULT ('   ') FOR [B1_GRPCST]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_CEST_DF]  DEFAULT ('         ') FOR [B1_CEST]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_AFUNDES_DF]  DEFAULT ((0)) FOR [B1_AFUNDES]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_AIMAMT_DF]  DEFAULT ((0)) FOR [B1_AIMAMT]
GO
ALTER TABLE [dbo].[SB1010] ADD  CONSTRAINT [SB1010_B1_AFASEMT_DF]  DEFAULT ((0)) FOR [B1_AFASEMT]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_FILIAL_DF]  DEFAULT ('  ') FOR [B2_FILIAL]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_COD_DF]  DEFAULT ('               ') FOR [B2_COD]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_QFIM_DF]  DEFAULT ((0)) FOR [B2_QFIM]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_LOCAL_DF]  DEFAULT ('  ') FOR [B2_LOCAL]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_QATU_DF]  DEFAULT ((0)) FOR [B2_QATU]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_VFIM1_DF]  DEFAULT ((0)) FOR [B2_VFIM1]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_VATU1_DF]  DEFAULT ((0)) FOR [B2_VATU1]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_CM1_DF]  DEFAULT ((0)) FOR [B2_CM1]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_VFIM2_DF]  DEFAULT ((0)) FOR [B2_VFIM2]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_VATU2_DF]  DEFAULT ((0)) FOR [B2_VATU2]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_CM2_DF]  DEFAULT ((0)) FOR [B2_CM2]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_VFIM3_DF]  DEFAULT ((0)) FOR [B2_VFIM3]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_VATU3_DF]  DEFAULT ((0)) FOR [B2_VATU3]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_CM3_DF]  DEFAULT ((0)) FOR [B2_CM3]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_VFIM4_DF]  DEFAULT ((0)) FOR [B2_VFIM4]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_VATU4_DF]  DEFAULT ((0)) FOR [B2_VATU4]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_CM4_DF]  DEFAULT ((0)) FOR [B2_CM4]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_VFIM5_DF]  DEFAULT ((0)) FOR [B2_VFIM5]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_VATU5_DF]  DEFAULT ((0)) FOR [B2_VATU5]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_CM5_DF]  DEFAULT ((0)) FOR [B2_CM5]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_QEMP_DF]  DEFAULT ((0)) FOR [B2_QEMP]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_QEMPN_DF]  DEFAULT ((0)) FOR [B2_QEMPN]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_QTSEGUM_DF]  DEFAULT ((0)) FOR [B2_QTSEGUM]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_USAI_DF]  DEFAULT ('        ') FOR [B2_USAI]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_RESERVA_DF]  DEFAULT ((0)) FOR [B2_RESERVA]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_QPEDVEN_DF]  DEFAULT ((0)) FOR [B2_QPEDVEN]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_LOCALIZ_DF]  DEFAULT ('               ') FOR [B2_LOCALIZ]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_NAOCLAS_DF]  DEFAULT ((0)) FOR [B2_NAOCLAS]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_SALPEDI_DF]  DEFAULT ((0)) FOR [B2_SALPEDI]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_DINVENT_DF]  DEFAULT ('        ') FOR [B2_DINVENT]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_DINVFIM_DF]  DEFAULT ('        ') FOR [B2_DINVFIM]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_QTNP_DF]  DEFAULT ((0)) FOR [B2_QTNP]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_QNPT_DF]  DEFAULT ((0)) FOR [B2_QNPT]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_QTER_DF]  DEFAULT ((0)) FOR [B2_QTER]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_QFIM2_DF]  DEFAULT ((0)) FOR [B2_QFIM2]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_QACLASS_DF]  DEFAULT ((0)) FOR [B2_QACLASS]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_DTINV_DF]  DEFAULT ('        ') FOR [B2_DTINV]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_CMFF1_DF]  DEFAULT ((0)) FOR [B2_CMFF1]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_CMFF2_DF]  DEFAULT ((0)) FOR [B2_CMFF2]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_CMFF3_DF]  DEFAULT ((0)) FOR [B2_CMFF3]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_CMFF4_DF]  DEFAULT ((0)) FOR [B2_CMFF4]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_CMFF5_DF]  DEFAULT ((0)) FOR [B2_CMFF5]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_VFIMFF1_DF]  DEFAULT ((0)) FOR [B2_VFIMFF1]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_VFIMFF2_DF]  DEFAULT ((0)) FOR [B2_VFIMFF2]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_VFIMFF3_DF]  DEFAULT ((0)) FOR [B2_VFIMFF3]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_VFIMFF4_DF]  DEFAULT ((0)) FOR [B2_VFIMFF4]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_VFIMFF5_DF]  DEFAULT ((0)) FOR [B2_VFIMFF5]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_QEMPSA_DF]  DEFAULT ((0)) FOR [B2_QEMPSA]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_QEMPPRE_DF]  DEFAULT ((0)) FOR [B2_QEMPPRE]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_SALPPRE_DF]  DEFAULT ((0)) FOR [B2_SALPPRE]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_QEMP2_DF]  DEFAULT ((0)) FOR [B2_QEMP2]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_QEMPN2_DF]  DEFAULT ((0)) FOR [B2_QEMPN2]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_RESERV2_DF]  DEFAULT ((0)) FOR [B2_RESERV2]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_QPEDVE2_DF]  DEFAULT ((0)) FOR [B2_QPEDVE2]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_QEPRE2_DF]  DEFAULT ((0)) FOR [B2_QEPRE2]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_QFIMFF_DF]  DEFAULT ((0)) FOR [B2_QFIMFF]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_SALPED2_DF]  DEFAULT ((0)) FOR [B2_SALPED2]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_QEMPPRJ_DF]  DEFAULT ((0)) FOR [B2_QEMPPRJ]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_QEMPPR2_DF]  DEFAULT ((0)) FOR [B2_QEMPPR2]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_STATUS_DF]  DEFAULT (' ') FOR [B2_STATUS]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_CMFIM1_DF]  DEFAULT ((0)) FOR [B2_CMFIM1]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_CMFIM2_DF]  DEFAULT ((0)) FOR [B2_CMFIM2]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_CMFIM3_DF]  DEFAULT ((0)) FOR [B2_CMFIM3]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_CMFIM4_DF]  DEFAULT ((0)) FOR [B2_CMFIM4]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_CMFIM5_DF]  DEFAULT ((0)) FOR [B2_CMFIM5]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_TIPO_DF]  DEFAULT (' ') FOR [B2_TIPO]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_D_E_L_E_T__DF]  DEFAULT (' ') FOR [D_E_L_E_T_]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_R_E_C_N_O__DF]  DEFAULT ((0)) FOR [R_E_C_N_O_]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_R_E_C_D_E_L__DF]  DEFAULT ((0)) FOR [R_E_C_D_E_L_]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_BLOQUEI_DF]  DEFAULT (' ') FOR [B2_BLOQUEI]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_CMRP1_DF]  DEFAULT ((0)) FOR [B2_CMRP1]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_VFRP1_DF]  DEFAULT ((0)) FOR [B2_VFRP1]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_CMRP2_DF]  DEFAULT ((0)) FOR [B2_CMRP2]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_VFRP2_DF]  DEFAULT ((0)) FOR [B2_VFRP2]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_CMRP3_DF]  DEFAULT ((0)) FOR [B2_CMRP3]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_VFRP3_DF]  DEFAULT ((0)) FOR [B2_VFRP3]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_CMRP4_DF]  DEFAULT ((0)) FOR [B2_CMRP4]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_VFRP4_DF]  DEFAULT ((0)) FOR [B2_VFRP4]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_CMRP5_DF]  DEFAULT ((0)) FOR [B2_CMRP5]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_VFRP5_DF]  DEFAULT ((0)) FOR [B2_VFRP5]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_QULT_DF]  DEFAULT ((0)) FOR [B2_QULT]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_DULT_DF]  DEFAULT ('        ') FOR [B2_DULT]
GO
ALTER TABLE [dbo].[SB2010] ADD  CONSTRAINT [SB2010_B2_MSEXP_DF]  DEFAULT ('        ') FOR [B2_MSEXP]
GO
ALTER TABLE [dbo].[SBM010] ADD  CONSTRAINT [SBM010_BM_FILIAL_DF]  DEFAULT ('  ') FOR [BM_FILIAL]
GO
ALTER TABLE [dbo].[SBM010] ADD  CONSTRAINT [SBM010_BM_GRUPO_DF]  DEFAULT ('    ') FOR [BM_GRUPO]
GO
ALTER TABLE [dbo].[SBM010] ADD  CONSTRAINT [SBM010_BM_DESC_DF]  DEFAULT ('                              ') FOR [BM_DESC]
GO
ALTER TABLE [dbo].[SBM010] ADD  CONSTRAINT [SBM010_BM_PICPAD_DF]  DEFAULT ('                              ') FOR [BM_PICPAD]
GO
ALTER TABLE [dbo].[SBM010] ADD  CONSTRAINT [SBM010_BM_PROORI_DF]  DEFAULT (' ') FOR [BM_PROORI]
GO
ALTER TABLE [dbo].[SBM010] ADD  CONSTRAINT [SBM010_BM_CODMAR_DF]  DEFAULT ('   ') FOR [BM_CODMAR]
GO
ALTER TABLE [dbo].[SBM010] ADD  CONSTRAINT [SBM010_BM_STATUS_DF]  DEFAULT (' ') FOR [BM_STATUS]
GO
ALTER TABLE [dbo].[SBM010] ADD  CONSTRAINT [SBM010_BM_GRUREL_DF]  DEFAULT ('                                        ') FOR [BM_GRUREL]
GO
ALTER TABLE [dbo].[SBM010] ADD  CONSTRAINT [SBM010_BM_TIPGRU_DF]  DEFAULT ('  ') FOR [BM_TIPGRU]
GO
ALTER TABLE [dbo].[SBM010] ADD  CONSTRAINT [SBM010_BM_MARKUP_DF]  DEFAULT ((0)) FOR [BM_MARKUP]
GO
ALTER TABLE [dbo].[SBM010] ADD  CONSTRAINT [SBM010_BM_PRECO_DF]  DEFAULT ('   ') FOR [BM_PRECO]
GO
ALTER TABLE [dbo].[SBM010] ADD  CONSTRAINT [SBM010_BM_LENREL_DF]  DEFAULT ((0)) FOR [BM_LENREL]
GO
ALTER TABLE [dbo].[SBM010] ADD  CONSTRAINT [SBM010_BM_TIPMOV_DF]  DEFAULT (' ') FOR [BM_TIPMOV]
GO
ALTER TABLE [dbo].[SBM010] ADD  CONSTRAINT [SBM010_D_E_L_E_T__DF]  DEFAULT (' ') FOR [D_E_L_E_T_]
GO
ALTER TABLE [dbo].[SBM010] ADD  CONSTRAINT [SBM010_R_E_C_N_O__DF]  DEFAULT ((0)) FOR [R_E_C_N_O_]
GO
ALTER TABLE [dbo].[SBM010] ADD  CONSTRAINT [SBM010_R_E_C_D_E_L__DF]  DEFAULT ((0)) FOR [R_E_C_D_E_L_]
GO
ALTER TABLE [dbo].[SBM010] ADD  CONSTRAINT [SBM010_BM_X_CONTA_DF]  DEFAULT ('                    ') FOR [BM_X_CONTA]
GO
ALTER TABLE [dbo].[SBM010] ADD  CONSTRAINT [SBM010_BM__BLQREC_DF]  DEFAULT (' ') FOR [BM__BLQREC]
GO
ALTER TABLE [dbo].[SBM010] ADD  CONSTRAINT [SBM010_BM_CLASGRU_DF]  DEFAULT (' ') FOR [BM_CLASGRU]
GO
ALTER TABLE [dbo].[SBM010] ADD  CONSTRAINT [SBM010_BM_FORMUL_DF]  DEFAULT ('      ') FOR [BM_FORMUL]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_FILIAL_DF]  DEFAULT ('  ') FOR [C5_FILIAL]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_NUM_DF]  DEFAULT ('      ') FOR [C5_NUM]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_TIPO_DF]  DEFAULT (' ') FOR [C5_TIPO]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_CLIENTE_DF]  DEFAULT ('      ') FOR [C5_CLIENTE]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_LOJACLI_DF]  DEFAULT ('  ') FOR [C5_LOJACLI]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_CLIENT_DF]  DEFAULT ('      ') FOR [C5_CLIENT]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_LOJAENT_DF]  DEFAULT ('  ') FOR [C5_LOJAENT]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_TRANSP_DF]  DEFAULT ('      ') FOR [C5_TRANSP]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_TIPOCLI_DF]  DEFAULT (' ') FOR [C5_TIPOCLI]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_CONDPAG_DF]  DEFAULT ('   ') FOR [C5_CONDPAG]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_TABELA_DF]  DEFAULT ('   ') FOR [C5_TABELA]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_VEND1_DF]  DEFAULT ('      ') FOR [C5_VEND1]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_COMIS1_DF]  DEFAULT ((0)) FOR [C5_COMIS1]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_VEND2_DF]  DEFAULT ('      ') FOR [C5_VEND2]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_COMIS2_DF]  DEFAULT ((0)) FOR [C5_COMIS2]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_VEND3_DF]  DEFAULT ('      ') FOR [C5_VEND3]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_COMIS3_DF]  DEFAULT ((0)) FOR [C5_COMIS3]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_VEND4_DF]  DEFAULT ('      ') FOR [C5_VEND4]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_COMIS4_DF]  DEFAULT ((0)) FOR [C5_COMIS4]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_VEND5_DF]  DEFAULT ('      ') FOR [C5_VEND5]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_COMIS5_DF]  DEFAULT ((0)) FOR [C5_COMIS5]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_DESC1_DF]  DEFAULT ((0)) FOR [C5_DESC1]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_DESC2_DF]  DEFAULT ((0)) FOR [C5_DESC2]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_DESC3_DF]  DEFAULT ((0)) FOR [C5_DESC3]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_DESC4_DF]  DEFAULT ((0)) FOR [C5_DESC4]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_BANCO_DF]  DEFAULT ('   ') FOR [C5_BANCO]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_DESCFI_DF]  DEFAULT ((0)) FOR [C5_DESCFI]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_EMISSAO_DF]  DEFAULT ('        ') FOR [C5_EMISSAO]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_COTACAO_DF]  DEFAULT ('      ') FOR [C5_COTACAO]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_PARC1_DF]  DEFAULT ((0)) FOR [C5_PARC1]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_DATA1_DF]  DEFAULT ('        ') FOR [C5_DATA1]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_PARC2_DF]  DEFAULT ((0)) FOR [C5_PARC2]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_DATA2_DF]  DEFAULT ('        ') FOR [C5_DATA2]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_PARC3_DF]  DEFAULT ((0)) FOR [C5_PARC3]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_DATA3_DF]  DEFAULT ('        ') FOR [C5_DATA3]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_PARC4_DF]  DEFAULT ((0)) FOR [C5_PARC4]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_DATA4_DF]  DEFAULT ('        ') FOR [C5_DATA4]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_TPFRETE_DF]  DEFAULT (' ') FOR [C5_TPFRETE]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_FRETE_DF]  DEFAULT ((0)) FOR [C5_FRETE]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_SEGURO_DF]  DEFAULT ((0)) FOR [C5_SEGURO]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_DESPESA_DF]  DEFAULT ((0)) FOR [C5_DESPESA]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_FRETAUT_DF]  DEFAULT ((0)) FOR [C5_FRETAUT]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_REAJUST_DF]  DEFAULT ('   ') FOR [C5_REAJUST]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_MOEDA_DF]  DEFAULT ((0)) FOR [C5_MOEDA]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_PESOL_DF]  DEFAULT ((0)) FOR [C5_PESOL]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_PBRUTO_DF]  DEFAULT ((0)) FOR [C5_PBRUTO]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_REIMP_DF]  DEFAULT ((0)) FOR [C5_REIMP]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_REDESP_DF]  DEFAULT ('      ') FOR [C5_REDESP]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_VOLUME1_DF]  DEFAULT ((0)) FOR [C5_VOLUME1]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_VOLUME2_DF]  DEFAULT ((0)) FOR [C5_VOLUME2]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_VOLUME3_DF]  DEFAULT ((0)) FOR [C5_VOLUME3]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_VOLUME4_DF]  DEFAULT ((0)) FOR [C5_VOLUME4]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_ESPECI1_DF]  DEFAULT ('          ') FOR [C5_ESPECI1]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_ESPECI2_DF]  DEFAULT ('          ') FOR [C5_ESPECI2]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_ESPECI3_DF]  DEFAULT ('          ') FOR [C5_ESPECI3]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_ESPECI4_DF]  DEFAULT ('          ') FOR [C5_ESPECI4]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_ACRSFIN_DF]  DEFAULT ((0)) FOR [C5_ACRSFIN]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_MENNOTA_DF]  DEFAULT ('                                                            ') FOR [C5_MENNOTA]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_MENPAD_DF]  DEFAULT ('   ') FOR [C5_MENPAD]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_INCISS_DF]  DEFAULT (' ') FOR [C5_INCISS]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_LIBEROK_DF]  DEFAULT (' ') FOR [C5_LIBEROK]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_OK_DF]  DEFAULT ('  ') FOR [C5_OK]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_NOTA_DF]  DEFAULT ('         ') FOR [C5_NOTA]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_SERIE_DF]  DEFAULT ('   ') FOR [C5_SERIE]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_KITREP_DF]  DEFAULT ('      ') FOR [C5_KITREP]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_OS_DF]  DEFAULT ('      ') FOR [C5_OS]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_TIPLIB_DF]  DEFAULT (' ') FOR [C5_TIPLIB]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_DESCONT_DF]  DEFAULT ((0)) FOR [C5_DESCONT]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_PEDEXP_DF]  DEFAULT ('                    ') FOR [C5_PEDEXP]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_TXMOEDA_DF]  DEFAULT ((0)) FOR [C5_TXMOEDA]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_TPCARGA_DF]  DEFAULT (' ') FOR [C5_TPCARGA]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_PDESCAB_DF]  DEFAULT ((0)) FOR [C5_PDESCAB]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_BLQ_DF]  DEFAULT (' ') FOR [C5_BLQ]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_FORNISS_DF]  DEFAULT ('      ') FOR [C5_FORNISS]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_CONTRA_DF]  DEFAULT ('          ') FOR [C5_CONTRA]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_VLR_FRT_DF]  DEFAULT ((0)) FOR [C5_VLR_FRT]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_MDCONTR_DF]  DEFAULT ('               ') FOR [C5_MDCONTR]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_GERAWMS_DF]  DEFAULT (' ') FOR [C5_GERAWMS]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_MDNUMED_DF]  DEFAULT ('      ') FOR [C5_MDNUMED]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_MDPLANI_DF]  DEFAULT ('      ') FOR [C5_MDPLANI]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_SOLFRE_DF]  DEFAULT ('  ') FOR [C5_SOLFRE]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_ORCRES_DF]  DEFAULT ('      ') FOR [C5_ORCRES]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_RECFAUT_DF]  DEFAULT (' ') FOR [C5_RECFAUT]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_RECISS_DF]  DEFAULT (' ') FOR [C5_RECISS]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_D_E_L_E_T__DF]  DEFAULT (' ') FOR [D_E_L_E_T_]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_R_E_C_N_O__DF]  DEFAULT ((0)) FOR [R_E_C_N_O_]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_R_E_C_D_E_L__DF]  DEFAULT ((0)) FOR [R_E_C_D_E_L_]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_DTINC_DF]  DEFAULT ('        ') FOR [C5_X_DTINC]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_CDUSR_DF]  DEFAULT ('      ') FOR [C5_X_CDUSR]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_NOUSR_DF]  DEFAULT ('                              ') FOR [C5_X_NOUSR]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_HRINC_DF]  DEFAULT ('        ') FOR [C5_X_HRINC]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_NOCLI_DF]  DEFAULT ('                                        ') FOR [C5_X_NOCLI]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_PARC5_DF]  DEFAULT ((0)) FOR [C5_PARC5]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_PARC6_DF]  DEFAULT ((0)) FOR [C5_PARC6]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_DATA5_DF]  DEFAULT ('        ') FOR [C5_DATA5]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_DATA6_DF]  DEFAULT ('        ') FOR [C5_DATA6]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_NPARC_DF]  DEFAULT ('  ') FOR [C5_X_NPARC]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_PARC7_DF]  DEFAULT ((0)) FOR [C5_PARC7]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_DATA7_DF]  DEFAULT ('        ') FOR [C5_DATA7]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_COND9_DF]  DEFAULT ('   ') FOR [C5_X_COND9]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_FLGCO_DF]  DEFAULT (' ') FOR [C5_X_FLGCO]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_TXTCO_DF]  DEFAULT ('                    ') FOR [C5_X_TXTCO]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_ORIG_DF]  DEFAULT (' ') FOR [C5_X_ORIG]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_PEDCL_DF]  DEFAULT ('         ') FOR [C5_X_PEDCL]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_CODFR_DF]  DEFAULT ('       ') FOR [C5_X_CODFR]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_STATU_DF]  DEFAULT ('   ') FOR [C5_X_STATU]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_ATEND_DF]  DEFAULT ((0)) FOR [C5_X_ATEND]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_FORMA_DF]  DEFAULT ('   ') FOR [C5_X_FORMA]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_SERIE_DF]  DEFAULT ('   ') FOR [C5_X_SERIE]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_NOTA_DF]  DEFAULT ('            ') FOR [C5_X_NOTA]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_ID_DF]  DEFAULT ('              ') FOR [C5_X_ID]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_PLACA_DF]  DEFAULT ('       ') FOR [C5_X_PLACA]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_SITUA_DF]  DEFAULT ('   ') FOR [C5_X_SITUA]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_FILOR_DF]  DEFAULT ('  ') FOR [C5_X_FILOR]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_PEDOR_DF]  DEFAULT ('      ') FOR [C5_X_PEDOR]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_FILDE_DF]  DEFAULT ('  ') FOR [C5_X_FILDE]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_PEDDE_DF]  DEFAULT ('      ') FOR [C5_X_PEDDE]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_PARC1_DF]  DEFAULT ((0)) FOR [C5_X_PARC1]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_PARC2_DF]  DEFAULT ((0)) FOR [C5_X_PARC2]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_PARC3_DF]  DEFAULT ((0)) FOR [C5_X_PARC3]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_PARC4_DF]  DEFAULT ((0)) FOR [C5_X_PARC4]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_PARC5_DF]  DEFAULT ((0)) FOR [C5_X_PARC5]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_PARC6_DF]  DEFAULT ((0)) FOR [C5_X_PARC6]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_PARC7_DF]  DEFAULT ((0)) FOR [C5_X_PARC7]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_OBPEN_DF]  DEFAULT ('                                                                                ') FOR [C5_X_OBPEN]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5__SERIE_DF]  DEFAULT (' ') FOR [C5__SERIE]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_TPPED_DF]  DEFAULT (' ') FOR [C5_X_TPPED]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_OPER_DF]  DEFAULT ('  ') FOR [C5_X_OPER]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_TRANS_DF]  DEFAULT ('      ') FOR [C5_X_TRANS]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_USIMP_DF]  DEFAULT ('                    ') FOR [C5_X_USIMP]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_DTIMP_DF]  DEFAULT ('        ') FOR [C5_X_DTIMP]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_HRIMP_DF]  DEFAULT ('        ') FOR [C5_X_HRIMP]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_NRIMP_DF]  DEFAULT ((0)) FOR [C5_X_NRIMP]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_ADMFI_DF]  DEFAULT ('   ') FOR [C5_X_ADMFI]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_COMIS_DF]  DEFAULT ((0)) FOR [C5_X_COMIS]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_UNIMP_DF]  DEFAULT (' ') FOR [C5_X_UNIMP]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_VEND2_DF]  DEFAULT ('      ') FOR [C5_X_VEND2]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_VEND3_DF]  DEFAULT ('      ') FOR [C5_X_VEND3]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_PEDSE_DF]  DEFAULT (' ') FOR [C5_X_PEDSE]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_DTATU_DF]  DEFAULT ('        ') FOR [C5_X_DTATU]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_HRATU_DF]  DEFAULT ('        ') FOR [C5_X_HRATU]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_USATU_DF]  DEFAULT ('                    ') FOR [C5_X_USATU]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_ARQPO_DF]  DEFAULT ('                                        ') FOR [C5_X_ARQPO]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_USFTP_DF]  DEFAULT ('                    ') FOR [C5_X_USFTP]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_DTFTP_DF]  DEFAULT ('        ') FOR [C5_X_DTFTP]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_HRFTP_DF]  DEFAULT ('        ') FOR [C5_X_HRFTP]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_PAUSA_DF]  DEFAULT (' ') FOR [C5_X_PAUSA]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_NPOCK_DF]  DEFAULT ('          ') FOR [C5_X_NPOCK]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_TPOPE_DF]  DEFAULT ('      ') FOR [C5_X_TPOPE]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_CATEG_DF]  DEFAULT (' ') FOR [C5_X_CATEG]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_DTENT_DF]  DEFAULT ('        ') FOR [C5_X_DTENT]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_DTIM_DF]  DEFAULT ('        ') FOR [C5_X_DTIM]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_OBSPK_DF]  DEFAULT ('                                                                                                                                ') FOR [C5_X_OBSPK]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_TAB_DF]  DEFAULT ('      ') FOR [C5_X_TAB]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_PCFIL_DF]  DEFAULT ('  ') FOR [C5_X_PCFIL]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_PCNUM_DF]  DEFAULT ('      ') FOR [C5_X_PCNUM]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_PEDPR_DF]  DEFAULT ('      ') FOR [C5_X_PEDPR]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_PARC8_DF]  DEFAULT ((0)) FOR [C5_PARC8]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_DATA8_DF]  DEFAULT ('        ') FOR [C5_DATA8]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_PARC9_DF]  DEFAULT ((0)) FOR [C5_PARC9]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_DATA9_DF]  DEFAULT ('        ') FOR [C5_DATA9]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_PARC8_DF]  DEFAULT ((0)) FOR [C5_X_PARC8]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_PARC9_DF]  DEFAULT ((0)) FOR [C5_X_PARC9]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_PARCA_DF]  DEFAULT ((0)) FOR [C5_PARCA]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_DATAA_DF]  DEFAULT ('        ') FOR [C5_DATAA]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_PARCA_DF]  DEFAULT ((0)) FOR [C5_X_PARCA]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_DTAB_DF]  DEFAULT ((0)) FOR [C5_X_DTAB]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_DELIV_DF]  DEFAULT (' ') FOR [C5_X_DELIV]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_MUNPRES_DF]  DEFAULT ('       ') FOR [C5_MUNPRES]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_DESCMUN_DF]  DEFAULT ('                              ') FOR [C5_DESCMUN]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_NCART_DF]  DEFAULT ('                   ') FOR [C5_X_NCART]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_UFEMB_DF]  DEFAULT ('  ') FOR [C5_X_UFEMB]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_LOEMB_DF]  DEFAULT ('                    ') FOR [C5_X_LOEMB]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_IMPBO_DF]  DEFAULT (' ') FOR [C5_X_IMPBO]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_VEICULO_DF]  DEFAULT ('        ') FOR [C5_VEICULO]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_NFSUBST_DF]  DEFAULT ('         ') FOR [C5_NFSUBST]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_SERSUBS_DF]  DEFAULT ('   ') FOR [C5_SERSUBS]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_SALDO_DF]  DEFAULT ((0)) FOR [C5_X_SALDO]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_DTAPR_DF]  DEFAULT ('        ') FOR [C5_X_DTAPR]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_HRAPR_DF]  DEFAULT ('        ') FOR [C5_X_HRAPR]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_CDAPR_DF]  DEFAULT ('      ') FOR [C5_X_CDAPR]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_NOAPR_DF]  DEFAULT ('                                        ') FOR [C5_X_NOAPR]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_OBAPR_DF]  DEFAULT ('                                                                                                    ') FOR [C5_X_OBAPR]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_SDAPR_DF]  DEFAULT ((0)) FOR [C5_X_SDAPR]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_LGAPR_DF]  DEFAULT ('                                                                                                                        ') FOR [C5_X_LGAPR]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_DESCO_DF]  DEFAULT (' ') FOR [C5_X_DESCO]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_TXREF_DF]  DEFAULT ((0)) FOR [C5_TXREF]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_DTTXREF_DF]  DEFAULT ('        ') FOR [C5_DTTXREF]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_MOEDTIT_DF]  DEFAULT ((0)) FOR [C5_MOEDTIT]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_AGLPD_DF]  DEFAULT ('      ') FOR [C5_X_AGLPD]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_BALCA_DF]  DEFAULT (' ') FOR [C5_X_BALCA]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_CDNSU_DF]  DEFAULT ('                    ') FOR [C5_X_CDNSU]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_CDAUT_DF]  DEFAULT ('                              ') FOR [C5_X_CDAUT]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_ESTPRES_DF]  DEFAULT ('  ') FOR [C5_ESTPRES]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_DTLANC_DF]  DEFAULT ('        ') FOR [C5_DTLANC]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_FECENT_DF]  DEFAULT ('        ') FOR [C5_FECENT]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_SOLOPC_DF]  DEFAULT (' ') FOR [C5_SOLOPC]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_SUGENT_DF]  DEFAULT ('        ') FOR [C5_SUGENT]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_CODED_DF]  DEFAULT ('               ') FOR [C5_CODED]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_NUMPR_DF]  DEFAULT ('               ') FOR [C5_NUMPR]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_PREPEMB_DF]  DEFAULT (' ') FOR [C5_PREPEMB]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_OBRA_DF]  DEFAULT ('          ') FOR [C5_OBRA]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_X_ARMAZ_DF]  DEFAULT ('  ') FOR [C5_X_ARMAZ]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_ORIGEM_DF]  DEFAULT ('               ') FOR [C5_ORIGEM]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_INDPRES_DF]  DEFAULT (' ') FOR [C5_INDPRES]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_NUMENT_DF]  DEFAULT ('         ') FOR [C5_NUMENT]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_DTESERV_DF]  DEFAULT ('        ') FOR [C5_DTESERV]
GO
ALTER TABLE [dbo].[SC5010] ADD  CONSTRAINT [SC5010_C5_NATUREZ_DF]  DEFAULT ('          ') FOR [C5_NATUREZ]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_FILIAL_DF]  DEFAULT ('  ') FOR [C6_FILIAL]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_ITEM_DF]  DEFAULT ('  ') FOR [C6_ITEM]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_PRODUTO_DF]  DEFAULT ('               ') FOR [C6_PRODUTO]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_UM_DF]  DEFAULT ('  ') FOR [C6_UM]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_QTDVEN_DF]  DEFAULT ((0)) FOR [C6_QTDVEN]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_PRCVEN_DF]  DEFAULT ((0)) FOR [C6_PRCVEN]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_VALOR_DF]  DEFAULT ((0)) FOR [C6_VALOR]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_QTDLIB_DF]  DEFAULT ((0)) FOR [C6_QTDLIB]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_QTDLIB2_DF]  DEFAULT ((0)) FOR [C6_QTDLIB2]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_SEGUM_DF]  DEFAULT ('  ') FOR [C6_SEGUM]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_TES_DF]  DEFAULT ('   ') FOR [C6_TES]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_UNSVEN_DF]  DEFAULT ((0)) FOR [C6_UNSVEN]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_LOCAL_DF]  DEFAULT ('  ') FOR [C6_LOCAL]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_CF_DF]  DEFAULT ('     ') FOR [C6_CF]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_QTDENT_DF]  DEFAULT ((0)) FOR [C6_QTDENT]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_QTDENT2_DF]  DEFAULT ((0)) FOR [C6_QTDENT2]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_CLI_DF]  DEFAULT ('      ') FOR [C6_CLI]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_DESCONT_DF]  DEFAULT ((0)) FOR [C6_DESCONT]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_VALDESC_DF]  DEFAULT ((0)) FOR [C6_VALDESC]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_ENTREG_DF]  DEFAULT ('        ') FOR [C6_ENTREG]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_LA_DF]  DEFAULT ('        ') FOR [C6_LA]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_LOJA_DF]  DEFAULT ('  ') FOR [C6_LOJA]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_NOTA_DF]  DEFAULT ('         ') FOR [C6_NOTA]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_SERIE_DF]  DEFAULT ('   ') FOR [C6_SERIE]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_DATFAT_DF]  DEFAULT ('        ') FOR [C6_DATFAT]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_NUM_DF]  DEFAULT ('      ') FOR [C6_NUM]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_COMIS1_DF]  DEFAULT ((0)) FOR [C6_COMIS1]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_COMIS2_DF]  DEFAULT ((0)) FOR [C6_COMIS2]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_COMIS3_DF]  DEFAULT ((0)) FOR [C6_COMIS3]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_COMIS4_DF]  DEFAULT ((0)) FOR [C6_COMIS4]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_COMIS5_DF]  DEFAULT ((0)) FOR [C6_COMIS5]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_PEDCLI_DF]  DEFAULT ('         ') FOR [C6_PEDCLI]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_DESCRI_DF]  DEFAULT ('                                                  ') FOR [C6_DESCRI]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_PRUNIT_DF]  DEFAULT ((0)) FOR [C6_PRUNIT]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_BLOQUEI_DF]  DEFAULT ('  ') FOR [C6_BLOQUEI]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_RESERVA_DF]  DEFAULT ('      ') FOR [C6_RESERVA]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_OP_DF]  DEFAULT ('  ') FOR [C6_OP]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_OK_DF]  DEFAULT ('  ') FOR [C6_OK]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_NFORI_DF]  DEFAULT ('         ') FOR [C6_NFORI]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_SERIORI_DF]  DEFAULT ('   ') FOR [C6_SERIORI]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_ITEMORI_DF]  DEFAULT ('    ') FOR [C6_ITEMORI]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_IPIDEV_DF]  DEFAULT ((0)) FOR [C6_IPIDEV]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_IDENTB6_DF]  DEFAULT ('      ') FOR [C6_IDENTB6]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_BLQ_DF]  DEFAULT ('  ') FOR [C6_BLQ]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_PICMRET_DF]  DEFAULT ((0)) FOR [C6_PICMRET]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_CODISS_DF]  DEFAULT ('         ') FOR [C6_CODISS]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_GRADE_DF]  DEFAULT (' ') FOR [C6_GRADE]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_ITEMGRD_DF]  DEFAULT ('   ') FOR [C6_ITEMGRD]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_LOTECTL_DF]  DEFAULT ('          ') FOR [C6_LOTECTL]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_NUMLOTE_DF]  DEFAULT ('      ') FOR [C6_NUMLOTE]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_DTVALID_DF]  DEFAULT ('        ') FOR [C6_DTVALID]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_NUMORC_DF]  DEFAULT ('        ') FOR [C6_NUMORC]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_CHASSI_DF]  DEFAULT ('                 ') FOR [C6_CHASSI]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_OPC_DF]  DEFAULT ('                                                                                ') FOR [C6_OPC]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_LOCALIZ_DF]  DEFAULT ('               ') FOR [C6_LOCALIZ]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_NUMSERI_DF]  DEFAULT ('                    ') FOR [C6_NUMSERI]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_NUMOP_DF]  DEFAULT ('      ') FOR [C6_NUMOP]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_ITEMOP_DF]  DEFAULT ('  ') FOR [C6_ITEMOP]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_CLASFIS_DF]  DEFAULT ('   ') FOR [C6_CLASFIS]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_QTDRESE_DF]  DEFAULT ((0)) FOR [C6_QTDRESE]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_CONTRAT_DF]  DEFAULT ('      ') FOR [C6_CONTRAT]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_NUMOS_DF]  DEFAULT ('          ') FOR [C6_NUMOS]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_NUMOSFA_DF]  DEFAULT ('          ') FOR [C6_NUMOSFA]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_CODFAB_DF]  DEFAULT ('      ') FOR [C6_CODFAB]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_LOJAFA_DF]  DEFAULT ('  ') FOR [C6_LOJAFA]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_ITEMCON_DF]  DEFAULT ('  ') FOR [C6_ITEMCON]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_TPOP_DF]  DEFAULT (' ') FOR [C6_TPOP]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_REVISAO_DF]  DEFAULT ('   ') FOR [C6_REVISAO]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_SERVIC_DF]  DEFAULT ('   ') FOR [C6_SERVIC]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_ENDPAD_DF]  DEFAULT ('               ') FOR [C6_ENDPAD]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_TPESTR_DF]  DEFAULT ('      ') FOR [C6_TPESTR]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_CONTRT_DF]  DEFAULT ('               ') FOR [C6_CONTRT]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_TPCONTR_DF]  DEFAULT (' ') FOR [C6_TPCONTR]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_ITCONTR_DF]  DEFAULT ('  ') FOR [C6_ITCONTR]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_GEROUPV_DF]  DEFAULT (' ') FOR [C6_GEROUPV]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_PROJPMS_DF]  DEFAULT ('          ') FOR [C6_PROJPMS]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_EDTPMS_DF]  DEFAULT ('            ') FOR [C6_EDTPMS]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_TASKPMS_DF]  DEFAULT ('            ') FOR [C6_TASKPMS]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_TRT_DF]  DEFAULT ('   ') FOR [C6_TRT]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_QTDEMP_DF]  DEFAULT ((0)) FOR [C6_QTDEMP]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_QTDEMP2_DF]  DEFAULT ((0)) FOR [C6_QTDEMP2]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_PROJET_DF]  DEFAULT ('      ') FOR [C6_PROJET]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_ITPROJ_DF]  DEFAULT ('  ') FOR [C6_ITPROJ]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_POTENCI_DF]  DEFAULT ((0)) FOR [C6_POTENCI]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_LICITA_DF]  DEFAULT ('      ') FOR [C6_LICITA]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_REGWMS_DF]  DEFAULT (' ') FOR [C6_REGWMS]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_NUMCP_DF]  DEFAULT ('      ') FOR [C6_NUMCP]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_NUMSC_DF]  DEFAULT ('      ') FOR [C6_NUMSC]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_ITEMSC_DF]  DEFAULT ('    ') FOR [C6_ITEMSC]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_SUGENTR_DF]  DEFAULT ('        ') FOR [C6_SUGENTR]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_ITEMED_DF]  DEFAULT ('   ') FOR [C6_ITEMED]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_ABSCINS_DF]  DEFAULT ((0)) FOR [C6_ABSCINS]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_ABATISS_DF]  DEFAULT ((0)) FOR [C6_ABATISS]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_ABATMAT_DF]  DEFAULT ((0)) FOR [C6_ABATMAT]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_FUNRURA_DF]  DEFAULT ((0)) FOR [C6_FUNRURA]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_FETAB_DF]  DEFAULT ((0)) FOR [C6_FETAB]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_CODROM_DF]  DEFAULT ('      ') FOR [C6_CODROM]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_D_E_L_E_T__DF]  DEFAULT (' ') FOR [D_E_L_E_T_]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_R_E_C_N_O__DF]  DEFAULT ((0)) FOR [R_E_C_N_O_]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_R_E_C_D_E_L__DF]  DEFAULT ((0)) FOR [R_E_C_D_E_L_]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_TABEL_DF]  DEFAULT ('   ') FOR [C6_X_TABEL]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_TXTCO_DF]  DEFAULT ('                                                                      ') FOR [C6_X_TXTCO]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_FLGCO_DF]  DEFAULT (' ') FOR [C6_X_FLGCO]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_PRCV_DF]  DEFAULT ((0)) FOR [C6_X_PRCV]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_PRUN_DF]  DEFAULT ((0)) FOR [C6_X_PRUN]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_TES_DF]  DEFAULT ('   ') FOR [C6_X_TES]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_TCOM_DF]  DEFAULT (' ') FOR [C6_X_TCOM]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_OBS_DF]  DEFAULT ('                                                                                ') FOR [C6_X_OBS]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_QTDCF_DF]  DEFAULT ((0)) FOR [C6_X_QTDCF]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_QTDOR_DF]  DEFAULT ((0)) FOR [C6_X_QTDOR]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_CODPM_DF]  DEFAULT ('      ') FOR [C6_X_CODPM]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_NOMPM_DF]  DEFAULT ('                    ') FOR [C6_X_NOMPM]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_OBSPM_DF]  DEFAULT ('                                                            ') FOR [C6_X_OBSPM]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_PRCPM_DF]  DEFAULT ((0)) FOR [C6_X_PRCPM]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_ITEM_DF]  DEFAULT ('   ') FOR [C6_X_ITEM]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_PROMO_DF]  DEFAULT (' ') FOR [C6_X_PROMO]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_FLGPM_DF]  DEFAULT (' ') FOR [C6_X_FLGPM]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_PRMIN_DF]  DEFAULT ((0)) FOR [C6_X_PRMIN]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_CODFR_DF]  DEFAULT ('          ') FOR [C6_X_CODFR]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_PRVEN_DF]  DEFAULT ((0)) FOR [C6_X_PRVEN]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_PREXP_DF]  DEFAULT ((0)) FOR [C6_X_PREXP]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_DESCP_DF]  DEFAULT ((0)) FOR [C6_X_DESCP]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_TPDEDUZ_DF]  DEFAULT (' ') FOR [C6_TPDEDUZ]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_MOTDED_DF]  DEFAULT (' ') FOR [C6_MOTDED]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_FORDED_DF]  DEFAULT ('      ') FOR [C6_FORDED]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_LOJDED_DF]  DEFAULT ('  ') FOR [C6_LOJDED]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_SERDED_DF]  DEFAULT ('   ') FOR [C6_SERDED]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_NFDED_DF]  DEFAULT ('         ') FOR [C6_NFDED]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_VLNFD_DF]  DEFAULT ((0)) FOR [C6_VLNFD]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_PCDED_DF]  DEFAULT ((0)) FOR [C6_PCDED]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_VLDED_DF]  DEFAULT ((0)) FOR [C6_VLDED]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6__PRUNIT_DF]  DEFAULT ((0)) FOR [C6__PRUNIT]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6__FLGCOM_DF]  DEFAULT (' ') FOR [C6__FLGCOM]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_BASVEIC_DF]  DEFAULT ((0)) FOR [C6_BASVEIC]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_ABATINS_DF]  DEFAULT ((0)) FOR [C6_ABATINS]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_CODLAN_DF]  DEFAULT ('      ') FOR [C6_CODLAN]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_CDSZN_DF]  DEFAULT ('      ') FOR [C6_X_CDSZN]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_PMSZN_DF]  DEFAULT ((0)) FOR [C6_X_PMSZN]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_OBSZN_DF]  DEFAULT ('                                                                                                                                            ') FOR [C6_X_OBSZN]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_CDSZM_DF]  DEFAULT ('      ') FOR [C6_X_CDSZM]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_DTSZM_DF]  DEFAULT ('        ') FOR [C6_X_DTSZM]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_HRSZM_DF]  DEFAULT ('        ') FOR [C6_X_HRSZM]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_OBSZM_DF]  DEFAULT ('                                                                                                                                                      ') FOR [C6_X_OBSZM]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_SALDO_DF]  DEFAULT ((0)) FOR [C6_X_SALDO]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_AUTMC_DF]  DEFAULT (' ') FOR [C6_X_AUTMC]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_MINTB_DF]  DEFAULT ((0)) FOR [C6_X_MINTB]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_PRSUG_DF]  DEFAULT ((0)) FOR [C6_X_PRSUG]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_MARGE_DF]  DEFAULT ((0)) FOR [C6_X_MARGE]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_APRMC_DF]  DEFAULT ((0)) FOR [C6_X_APRMC]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_DTAMC_DF]  DEFAULT ('        ') FOR [C6_X_DTAMC]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_HRAMC_DF]  DEFAULT ('        ') FOR [C6_X_HRAMC]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_X_USAMC_DF]  DEFAULT ('      ') FOR [C6_X_USAMC]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_TNATREC_DF]  DEFAULT ('    ') FOR [C6_TNATREC]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_CNATREC_DF]  DEFAULT ('   ') FOR [C6_CNATREC]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_GRPNATR_DF]  DEFAULT ('  ') FOR [C6_GRPNATR]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_DTFIMNT_DF]  DEFAULT ('        ') FOR [C6_DTFIMNT]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_ITEMPC_DF]  DEFAULT ('      ') FOR [C6_ITEMPC]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_NUMPCOM_DF]  DEFAULT ('               ') FOR [C6_NUMPCOM]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_PEDCOM_DF]  DEFAULT ('      ') FOR [C6_PEDCOM]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_ITPC_DF]  DEFAULT ('    ') FOR [C6_ITPC]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_FILPED_DF]  DEFAULT ('  ') FOR [C6_FILPED]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_PROGRAM_DF]  DEFAULT ('          ') FOR [C6_PROGRAM]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_TURNO_DF]  DEFAULT (' ') FOR [C6_TURNO]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_PVCOMOP_DF]  DEFAULT (' ') FOR [C6_PVCOMOP]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_VDMOST_DF]  DEFAULT (' ') FOR [C6_VDMOST]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_RATEIO_DF]  DEFAULT (' ') FOR [C6_RATEIO]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_ITLPRE_DF]  DEFAULT ('   ') FOR [C6_ITLPRE]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_D1SERIE_DF]  DEFAULT ('   ') FOR [C6_D1SERIE]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_D1DOC_DF]  DEFAULT ('               ') FOR [C6_D1DOC]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_CODLPRE_DF]  DEFAULT ('      ') FOR [C6_CODLPRE]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_D1ITEM_DF]  DEFAULT ('    ') FOR [C6_D1ITEM]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_VLIMPOR_DF]  DEFAULT ((0)) FOR [C6_VLIMPOR]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_FCICOD_DF]  DEFAULT ('                                    ') FOR [C6_FCICOD]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_CODINF_DF]  DEFAULT ('      ') FOR [C6_CODINF]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_HORENT_DF]  DEFAULT ('    ') FOR [C6_HORENT]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_PMSID_DF]  DEFAULT ('          ') FOR [C6_PMSID]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_PEDVINC_DF]  DEFAULT ('      ') FOR [C6_PEDVINC]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_PRODFIN_DF]  DEFAULT ('               ') FOR [C6_PRODFIN]
GO
ALTER TABLE [dbo].[SC6010] ADD  CONSTRAINT [SC6010_C6_REVPROD_DF]  DEFAULT ('   ') FOR [C6_REVPROD]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_FILIAL_DF]  DEFAULT ('  ') FOR [D1_FILIAL]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ITEM_DF]  DEFAULT ('    ') FOR [D1_ITEM]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_COD_DF]  DEFAULT ('               ') FOR [D1_COD]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_UM_DF]  DEFAULT ('  ') FOR [D1_UM]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_SEGUM_DF]  DEFAULT ('  ') FOR [D1_SEGUM]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_QUANT_DF]  DEFAULT ((0)) FOR [D1_QUANT]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VUNIT_DF]  DEFAULT ((0)) FOR [D1_VUNIT]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_TOTAL_DF]  DEFAULT ((0)) FOR [D1_TOTAL]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALIPI_DF]  DEFAULT ((0)) FOR [D1_VALIPI]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALICM_DF]  DEFAULT ((0)) FOR [D1_VALICM]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_TES_DF]  DEFAULT ('   ') FOR [D1_TES]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CF_DF]  DEFAULT ('     ') FOR [D1_CF]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_DESC_DF]  DEFAULT ((0)) FOR [D1_DESC]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_IPI_DF]  DEFAULT ((0)) FOR [D1_IPI]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_PICM_DF]  DEFAULT ((0)) FOR [D1_PICM]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_PESO_DF]  DEFAULT ((0)) FOR [D1_PESO]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CONTA_DF]  DEFAULT ('                    ') FOR [D1_CONTA]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ITEMCTA_DF]  DEFAULT ('           ') FOR [D1_ITEMCTA]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CC_DF]  DEFAULT ('         ') FOR [D1_CC]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_OP_DF]  DEFAULT ('             ') FOR [D1_OP]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_PEDIDO_DF]  DEFAULT ('      ') FOR [D1_PEDIDO]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ITEMPC_DF]  DEFAULT ('    ') FOR [D1_ITEMPC]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_FORNECE_DF]  DEFAULT ('      ') FOR [D1_FORNECE]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_LOJA_DF]  DEFAULT ('  ') FOR [D1_LOJA]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_LOCAL_DF]  DEFAULT ('  ') FOR [D1_LOCAL]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_DOC_DF]  DEFAULT ('         ') FOR [D1_DOC]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_EMISSAO_DF]  DEFAULT ('        ') FOR [D1_EMISSAO]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_DTDIGIT_DF]  DEFAULT ('        ') FOR [D1_DTDIGIT]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_GRUPO_DF]  DEFAULT ('    ') FOR [D1_GRUPO]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_TIPO_DF]  DEFAULT (' ') FOR [D1_TIPO]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_SERIE_DF]  DEFAULT ('   ') FOR [D1_SERIE]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CUSTO2_DF]  DEFAULT ((0)) FOR [D1_CUSTO2]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CUSTO3_DF]  DEFAULT ((0)) FOR [D1_CUSTO3]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CUSTO4_DF]  DEFAULT ((0)) FOR [D1_CUSTO4]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CUSTO5_DF]  DEFAULT ((0)) FOR [D1_CUSTO5]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_TP_DF]  DEFAULT ('  ') FOR [D1_TP]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_QTSEGUM_DF]  DEFAULT ((0)) FOR [D1_QTSEGUM]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_NUMSEQ_DF]  DEFAULT ('      ') FOR [D1_NUMSEQ]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_DATACUS_DF]  DEFAULT ('        ') FOR [D1_DATACUS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_NFORI_DF]  DEFAULT ('         ') FOR [D1_NFORI]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_SERIORI_DF]  DEFAULT ('   ') FOR [D1_SERIORI]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ITEMORI_DF]  DEFAULT ('    ') FOR [D1_ITEMORI]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_QTDEDEV_DF]  DEFAULT ((0)) FOR [D1_QTDEDEV]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALDEV_DF]  DEFAULT ((0)) FOR [D1_VALDEV]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ORIGLAN_DF]  DEFAULT ('  ') FOR [D1_ORIGLAN]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ICMSRET_DF]  DEFAULT ((0)) FOR [D1_ICMSRET]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BRICMS_DF]  DEFAULT ((0)) FOR [D1_BRICMS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_NUMCQ_DF]  DEFAULT ('      ') FOR [D1_NUMCQ]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_DATORI_DF]  DEFAULT ('        ') FOR [D1_DATORI]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASEICM_DF]  DEFAULT ((0)) FOR [D1_BASEICM]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALDESC_DF]  DEFAULT ((0)) FOR [D1_VALDESC]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_IDENTB6_DF]  DEFAULT ('      ') FOR [D1_IDENTB6]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_LOTEFOR_DF]  DEFAULT ('                  ') FOR [D1_LOTEFOR]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_SKIPLOT_DF]  DEFAULT (' ') FOR [D1_SKIPLOT]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASEIPI_DF]  DEFAULT ((0)) FOR [D1_BASEIPI]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_SEQCALC_DF]  DEFAULT ('              ') FOR [D1_SEQCALC]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_LOTECTL_DF]  DEFAULT ('          ') FOR [D1_LOTECTL]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_NUMLOTE_DF]  DEFAULT ('      ') FOR [D1_NUMLOTE]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_DTVALID_DF]  DEFAULT ('        ') FOR [D1_DTVALID]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_PLACA_DF]  DEFAULT ('       ') FOR [D1_PLACA]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CHASSI_DF]  DEFAULT ('                 ') FOR [D1_CHASSI]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ANOFAB_DF]  DEFAULT ('  ') FOR [D1_ANOFAB]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_MODFAB_DF]  DEFAULT ('  ') FOR [D1_MODFAB]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_MODELO_DF]  DEFAULT ('               ') FOR [D1_MODELO]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_COMBUST_DF]  DEFAULT ('          ') FOR [D1_COMBUST]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_COR_DF]  DEFAULT ('   ') FOR [D1_COR]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_EQUIPS_DF]  DEFAULT ('   ') FOR [D1_EQUIPS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_FORMUL_DF]  DEFAULT (' ') FOR [D1_FORMUL]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_II_DF]  DEFAULT ((0)) FOR [D1_II]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_TEC_DF]  DEFAULT ('                ') FOR [D1_TEC]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CONHEC_DF]  DEFAULT ('                 ') FOR [D1_CONHEC]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_NUMPV_DF]  DEFAULT ('      ') FOR [D1_NUMPV]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ITEMPV_DF]  DEFAULT ('  ') FOR [D1_ITEMPV]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CUSFF1_DF]  DEFAULT ((0)) FOR [D1_CUSFF1]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CUSFF2_DF]  DEFAULT ((0)) FOR [D1_CUSFF2]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CUSFF3_DF]  DEFAULT ((0)) FOR [D1_CUSFF3]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CUSFF4_DF]  DEFAULT ((0)) FOR [D1_CUSFF4]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CUSFF5_DF]  DEFAULT ((0)) FOR [D1_CUSFF5]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CODCIAP_DF]  DEFAULT ('      ') FOR [D1_CODCIAP]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CLASFIS_DF]  DEFAULT ('   ') FOR [D1_CLASFIS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASIMP1_DF]  DEFAULT ((0)) FOR [D1_BASIMP1]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_REMITO_DF]  DEFAULT ('         ') FOR [D1_REMITO]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_SERIREM_DF]  DEFAULT ('   ') FOR [D1_SERIREM]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CUSTO_DF]  DEFAULT ((0)) FOR [D1_CUSTO]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASIMP3_DF]  DEFAULT ((0)) FOR [D1_BASIMP3]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASIMP4_DF]  DEFAULT ((0)) FOR [D1_BASIMP4]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASIMP5_DF]  DEFAULT ((0)) FOR [D1_BASIMP5]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASIMP6_DF]  DEFAULT ((0)) FOR [D1_BASIMP6]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALIMP1_DF]  DEFAULT ((0)) FOR [D1_VALIMP1]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALIMP2_DF]  DEFAULT ((0)) FOR [D1_VALIMP2]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALIMP3_DF]  DEFAULT ((0)) FOR [D1_VALIMP3]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALIMP4_DF]  DEFAULT ((0)) FOR [D1_VALIMP4]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALIMP5_DF]  DEFAULT ((0)) FOR [D1_VALIMP5]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALIMP6_DF]  DEFAULT ((0)) FOR [D1_VALIMP6]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CBASEAF_DF]  DEFAULT ('              ') FOR [D1_CBASEAF]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ICMSCOM_DF]  DEFAULT ((0)) FOR [D1_ICMSCOM]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CIF_DF]  DEFAULT ((0)) FOR [D1_CIF]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ITEMREM_DF]  DEFAULT ('    ') FOR [D1_ITEMREM]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASIMP2_DF]  DEFAULT ((0)) FOR [D1_BASIMP2]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_TIPO_NF_DF]  DEFAULT (' ') FOR [D1_TIPO_NF]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALQIMP1_DF]  DEFAULT ((0)) FOR [D1_ALQIMP1]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALQIMP2_DF]  DEFAULT ((0)) FOR [D1_ALQIMP2]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALQIMP3_DF]  DEFAULT ((0)) FOR [D1_ALQIMP3]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALQIMP4_DF]  DEFAULT ((0)) FOR [D1_ALQIMP4]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALQIMP5_DF]  DEFAULT ((0)) FOR [D1_ALQIMP5]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALQIMP6_DF]  DEFAULT ((0)) FOR [D1_ALQIMP6]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_QTDPEDI_DF]  DEFAULT ((0)) FOR [D1_QTDPEDI]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALFRE_DF]  DEFAULT ((0)) FOR [D1_VALFRE]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_RATEIO_DF]  DEFAULT (' ') FOR [D1_RATEIO]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_SEGURO_DF]  DEFAULT ((0)) FOR [D1_SEGURO]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_DESPESA_DF]  DEFAULT ((0)) FOR [D1_DESPESA]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASEIRR_DF]  DEFAULT ((0)) FOR [D1_BASEIRR]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALIQIRR_DF]  DEFAULT ((0)) FOR [D1_ALIQIRR]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALIRR_DF]  DEFAULT ((0)) FOR [D1_VALIRR]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASEISS_DF]  DEFAULT ((0)) FOR [D1_BASEISS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALIQISS_DF]  DEFAULT ((0)) FOR [D1_ALIQISS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALISS_DF]  DEFAULT ((0)) FOR [D1_VALISS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASEINS_DF]  DEFAULT ((0)) FOR [D1_BASEINS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALIQINS_DF]  DEFAULT ((0)) FOR [D1_ALIQINS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALINS_DF]  DEFAULT ((0)) FOR [D1_VALINS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CUSORI_DF]  DEFAULT ((0)) FOR [D1_CUSORI]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_LOCPAD_DF]  DEFAULT ('      ') FOR [D1_LOCPAD]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CLVL_DF]  DEFAULT ('                    ') FOR [D1_CLVL]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ORDEM_DF]  DEFAULT ('      ') FOR [D1_ORDEM]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_SERVIC_DF]  DEFAULT ('   ') FOR [D1_SERVIC]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_STSERV_DF]  DEFAULT (' ') FOR [D1_STSERV]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ENDER_DF]  DEFAULT ('               ') FOR [D1_ENDER]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_TPESTR_DF]  DEFAULT ('      ') FOR [D1_TPESTR]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_REGWMS_DF]  DEFAULT (' ') FOR [D1_REGWMS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_TIPODOC_DF]  DEFAULT ('  ') FOR [D1_TIPODOC]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_POTENCI_DF]  DEFAULT ((0)) FOR [D1_POTENCI]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_TRT_DF]  DEFAULT ('   ') FOR [D1_TRT]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_TESACLA_DF]  DEFAULT ('   ') FOR [D1_TESACLA]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_NUMDESP_DF]  DEFAULT ('                ') FOR [D1_NUMDESP]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ORIGEM_DF]  DEFAULT ('   ') FOR [D1_ORIGEM]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_GRADE_DF]  DEFAULT (' ') FOR [D1_GRADE]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ITEMGRD_DF]  DEFAULT ('   ') FOR [D1_ITEMGRD]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_DESCICM_DF]  DEFAULT ((0)) FOR [D1_DESCICM]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CODISS_DF]  DEFAULT ('         ') FOR [D1_CODISS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASEPS3_DF]  DEFAULT ((0)) FOR [D1_BASEPS3]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALIQPS3_DF]  DEFAULT ((0)) FOR [D1_ALIQPS3]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALPS3_DF]  DEFAULT ((0)) FOR [D1_VALPS3]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASECF3_DF]  DEFAULT ((0)) FOR [D1_BASECF3]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALIQCF3_DF]  DEFAULT ((0)) FOR [D1_ALIQCF3]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALCF3_DF]  DEFAULT ((0)) FOR [D1_VALCF3]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CFPS_DF]  DEFAULT ('      ') FOR [D1_CFPS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALANTI_DF]  DEFAULT ((0)) FOR [D1_VALANTI]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_NFVINC_DF]  DEFAULT ('         ') FOR [D1_NFVINC]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_SERVINC_DF]  DEFAULT ('   ') FOR [D1_SERVINC]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ITMVINC_DF]  DEFAULT ('    ') FOR [D1_ITMVINC]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ICMSDIF_DF]  DEFAULT ((0)) FOR [D1_ICMSDIF]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ESTCRED_DF]  DEFAULT ((0)) FOR [D1_ESTCRED]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_PRUNDA_DF]  DEFAULT ((0)) FOR [D1_PRUNDA]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASESES_DF]  DEFAULT ((0)) FOR [D1_BASESES]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALSES_DF]  DEFAULT ((0)) FOR [D1_VALSES]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALIQSES_DF]  DEFAULT ((0)) FOR [D1_ALIQSES]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_GARANTI_DF]  DEFAULT (' ') FOR [D1_GARANTI]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CRPRESC_DF]  DEFAULT ((0)) FOR [D1_CRPRESC]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_RGESPST_DF]  DEFAULT (' ') FOR [D1_RGESPST]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALFDS_DF]  DEFAULT ((0)) FOR [D1_VALFDS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_PRFDSUL_DF]  DEFAULT ((0)) FOR [D1_PRFDSUL]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_UFERMS_DF]  DEFAULT ((0)) FOR [D1_UFERMS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D_E_L_E_T__DF]  DEFAULT (' ') FOR [D_E_L_E_T_]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_R_E_C_N_O__DF]  DEFAULT ((0)) FOR [R_E_C_N_O_]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_R_E_C_D_E_L__DF]  DEFAULT ((0)) FOR [R_E_C_D_E_L_]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_TRANSIT_DF]  DEFAULT (' ') FOR [D1_TRANSIT]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ABATISS_DF]  DEFAULT ((0)) FOR [D1_ABATISS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ABATMAT_DF]  DEFAULT ((0)) FOR [D1_ABATMAT]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ICMNDES_DF]  DEFAULT ((0)) FOR [D1_ICMNDES]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASNDES_DF]  DEFAULT ((0)) FOR [D1_BASNDES]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CRPRSIM_DF]  DEFAULT ((0)) FOR [D1_CRPRSIM]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALIQSOL_DF]  DEFAULT ((0)) FOR [D1_ALIQSOL]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALIQII_DF]  DEFAULT ((0)) FOR [D1_ALIQII]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_X_IMETQ_DF]  DEFAULT (' ') FOR [D1_X_IMETQ]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_X_VEND1_DF]  DEFAULT ('      ') FOR [D1_X_VEND1]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_X_MOTDV_DF]  DEFAULT ('   ') FOR [D1_X_MOTDV]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_DFABRIC_DF]  DEFAULT ('        ') FOR [D1_DFABRIC]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_MARGEM_DF]  DEFAULT ((0)) FOR [D1_MARGEM]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_SLDDEP_DF]  DEFAULT ((0)) FOR [D1_SLDDEP]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASEFAB_DF]  DEFAULT ((0)) FOR [D1_BASEFAB]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALIQFAB_DF]  DEFAULT ((0)) FOR [D1_ALIQFAB]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALFAB_DF]  DEFAULT ((0)) FOR [D1_VALFAB]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASEFAC_DF]  DEFAULT ((0)) FOR [D1_BASEFAC]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALIQFAC_DF]  DEFAULT ((0)) FOR [D1_ALIQFAC]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALFAC_DF]  DEFAULT ((0)) FOR [D1_VALFAC]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASEFET_DF]  DEFAULT ((0)) FOR [D1_BASEFET]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALIQFET_DF]  DEFAULT ((0)) FOR [D1_ALIQFET]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALFET_DF]  DEFAULT ((0)) FOR [D1_VALFET]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASEFUN_DF]  DEFAULT ((0)) FOR [D1_BASEFUN]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALIQFUN_DF]  DEFAULT ((0)) FOR [D1_ALIQFUN]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALFUN_DF]  DEFAULT ((0)) FOR [D1_VALFUN]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ABATINS_DF]  DEFAULT ((0)) FOR [D1_ABATINS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_AVLINSS_DF]  DEFAULT ((0)) FOR [D1_AVLINSS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CODLAN_DF]  DEFAULT ('      ') FOR [D1_CODLAN]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CRPREPR_DF]  DEFAULT ((0)) FOR [D1_CRPREPR]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CODBAIX_DF]  DEFAULT ('      ') FOR [D1_CODBAIX]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_TNATREC_DF]  DEFAULT ('    ') FOR [D1_TNATREC]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CNATREC_DF]  DEFAULT ('   ') FOR [D1_CNATREC]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_GRUPONC_DF]  DEFAULT ('  ') FOR [D1_GRUPONC]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_DTFIMNT_DF]  DEFAULT ('        ') FOR [D1_DTFIMNT]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALINA_DF]  DEFAULT ((0)) FOR [D1_VALINA]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASEINA_DF]  DEFAULT ((0)) FOR [D1_BASEINA]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALIQINA_DF]  DEFAULT ((0)) FOR [D1_ALIQINA]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASEPIS_DF]  DEFAULT ((0)) FOR [D1_BASEPIS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASECOF_DF]  DEFAULT ((0)) FOR [D1_BASECOF]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASECSL_DF]  DEFAULT ((0)) FOR [D1_BASECSL]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALPIS_DF]  DEFAULT ((0)) FOR [D1_VALPIS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALCOF_DF]  DEFAULT ((0)) FOR [D1_VALCOF]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALCSL_DF]  DEFAULT ((0)) FOR [D1_VALCSL]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALQPIS_DF]  DEFAULT ((0)) FOR [D1_ALQPIS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALQCOF_DF]  DEFAULT ((0)) FOR [D1_ALQCOF]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALQCSL_DF]  DEFAULT ((0)) FOR [D1_ALQCSL]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VLINCMG_DF]  DEFAULT ((0)) FOR [D1_VLINCMG]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_PRINCMG_DF]  DEFAULT ((0)) FOR [D1_PRINCMG]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_OKISS_DF]  DEFAULT ('  ') FOR [D1_OKISS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALCMAJ_DF]  DEFAULT ((0)) FOR [D1_VALCMAJ]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VLSENAR_DF]  DEFAULT ((0)) FOR [D1_VLSENAR]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BSSENAR_DF]  DEFAULT ((0)) FOR [D1_BSSENAR]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALSENAR_DF]  DEFAULT ((0)) FOR [D1_ALSENAR]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALACRS_DF]  DEFAULT ((0)) FOR [D1_VALACRS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_PCCENTR_DF]  DEFAULT ('      ') FOR [D1_PCCENTR]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ITPCCEN_DF]  DEFAULT ('    ') FOR [D1_ITPCCEN]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_QTPCCEN_DF]  DEFAULT ((0)) FOR [D1_QTPCCEN]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CRDZFM_DF]  DEFAULT ((0)) FOR [D1_CRDZFM]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_QTDCONF_DF]  DEFAULT ((0)) FOR [D1_QTDCONF]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CODNOR_DF]  DEFAULT ('      ') FOR [D1_CODNOR]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CONBAR_DF]  DEFAULT (' ') FOR [D1_CONBAR]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CUSRP4_DF]  DEFAULT ((0)) FOR [D1_CUSRP4]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CUSRP1_DF]  DEFAULT ((0)) FOR [D1_CUSRP1]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CUSRP5_DF]  DEFAULT ((0)) FOR [D1_CUSRP5]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CUSRP2_DF]  DEFAULT ((0)) FOR [D1_CUSRP2]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_OPERADO_DF]  DEFAULT ('   ') FOR [D1_OPERADO]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CUSRP3_DF]  DEFAULT ((0)) FOR [D1_CUSRP3]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_PROJ_DF]  DEFAULT ('          ') FOR [D1_PROJ]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALPMAJ_DF]  DEFAULT ((0)) FOR [D1_VALPMAJ]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_IDCFC_DF]  DEFAULT ('                    ') FOR [D1_IDCFC]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CONIMP_DF]  DEFAULT ((0)) FOR [D1_CONIMP]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_FCICOD_DF]  DEFAULT ('                                    ') FOR [D1_FCICOD]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VLCIDE_DF]  DEFAULT ((0)) FOR [D1_VLCIDE]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASECID_DF]  DEFAULT ((0)) FOR [D1_BASECID]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALQCIDE_DF]  DEFAULT ((0)) FOR [D1_ALQCIDE]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALCPM_DF]  DEFAULT ((0)) FOR [D1_VALCPM]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASECPM_DF]  DEFAULT ((0)) FOR [D1_BASECPM]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALQCPM_DF]  DEFAULT ((0)) FOR [D1_ALQCPM]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASEFMD_DF]  DEFAULT ((0)) FOR [D1_BASEFMD]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALQFMD_DF]  DEFAULT ((0)) FOR [D1_ALQFMD]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALFMD_DF]  DEFAULT ((0)) FOR [D1_VALFMD]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CODFIS_DF]  DEFAULT ('               ') FOR [D1_CODFIS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_IDSB5_DF]  DEFAULT ('                    ') FOR [D1_IDSB5]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_IDSB1_DF]  DEFAULT ('                    ') FOR [D1_IDSB1]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_IDSBZ_DF]  DEFAULT ('                    ') FOR [D1_IDSBZ]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_REVISAO_DF]  DEFAULT ('   ') FOR [D1_REVISAO]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_IDSF7_DF]  DEFAULT ('                    ') FOR [D1_IDSF7]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_IDSF4_DF]  DEFAULT ('                    ') FOR [D1_IDSF4]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_FILORI_DF]  DEFAULT ('  ') FOR [D1_FILORI]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_DESCZFR_DF]  DEFAULT ((0)) FOR [D1_DESCZFR]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_DESCZFP_DF]  DEFAULT ((0)) FOR [D1_DESCZFP]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_DESCZFC_DF]  DEFAULT ((0)) FOR [D1_DESCZFC]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALFMP_DF]  DEFAULT ((0)) FOR [D1_VALFMP]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASEFMP_DF]  DEFAULT ((0)) FOR [D1_BASEFMP]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALQFMP_DF]  DEFAULT ((0)) FOR [D1_ALQFMP]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_GRPCST_DF]  DEFAULT ('   ') FOR [D1_GRPCST]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASECPB_DF]  DEFAULT ((0)) FOR [D1_BASECPB]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALCPB_DF]  DEFAULT ((0)) FOR [D1_VALCPB]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALIQCPB_DF]  DEFAULT ((0)) FOR [D1_ALIQCPB]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_DIFAL_DF]  DEFAULT ((0)) FOR [D1_DIFAL]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_PDORI_DF]  DEFAULT ((0)) FOR [D1_PDORI]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_PDDES_DF]  DEFAULT ((0)) FOR [D1_PDDES]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALFCCMP_DF]  DEFAULT ((0)) FOR [D1_ALFCCMP]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALIQCMP_DF]  DEFAULT ((0)) FOR [D1_ALIQCMP]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASEDES_DF]  DEFAULT ((0)) FOR [D1_BASEDES]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VFCPDIF_DF]  DEFAULT ((0)) FOR [D1_VFCPDIF]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_FTRICMS_DF]  DEFAULT ((0)) FOR [D1_FTRICMS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VRDICMS_DF]  DEFAULT ((0)) FOR [D1_VRDICMS]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALFUND_DF]  DEFAULT ((0)) FOR [D1_VALFUND]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASFUND_DF]  DEFAULT ((0)) FOR [D1_BASFUND]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALIFUND_DF]  DEFAULT ((0)) FOR [D1_ALIFUND]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALIMA_DF]  DEFAULT ((0)) FOR [D1_VALIMA]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASIMA_DF]  DEFAULT ((0)) FOR [D1_BASIMA]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALIIMA_DF]  DEFAULT ((0)) FOR [D1_ALIIMA]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALFASE_DF]  DEFAULT ((0)) FOR [D1_VALFASE]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASFASE_DF]  DEFAULT ((0)) FOR [D1_BASFASE]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALIFASE_DF]  DEFAULT ((0)) FOR [D1_ALIFASE]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VLSLXML_DF]  DEFAULT ((0)) FOR [D1_VLSLXML]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_CSOSN_DF]  DEFAULT ('   ') FOR [D1_CSOSN]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_BASEINP_DF]  DEFAULT ((0)) FOR [D1_BASEINP]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_PERCINP_DF]  DEFAULT ((0)) FOR [D1_PERCINP]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALINP_DF]  DEFAULT ((0)) FOR [D1_VALINP]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_ALQFECP_DF]  DEFAULT ((0)) FOR [D1_ALQFECP]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VALFECP_DF]  DEFAULT ((0)) FOR [D1_VALFECP]
GO
ALTER TABLE [dbo].[SD1010] ADD  CONSTRAINT [SD1010_D1_VFECPST_DF]  DEFAULT ((0)) FOR [D1_VFECPST]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_FILIAL_DF]  DEFAULT ('  ') FOR [D2_FILIAL]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ITEM_DF]  DEFAULT ('  ') FOR [D2_ITEM]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_COD_DF]  DEFAULT ('               ') FOR [D2_COD]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_UM_DF]  DEFAULT ('  ') FOR [D2_UM]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_SEGUM_DF]  DEFAULT ('  ') FOR [D2_SEGUM]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_QUANT_DF]  DEFAULT ((0)) FOR [D2_QUANT]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_PRCVEN_DF]  DEFAULT ((0)) FOR [D2_PRCVEN]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_TOTAL_DF]  DEFAULT ((0)) FOR [D2_TOTAL]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALIPI_DF]  DEFAULT ((0)) FOR [D2_VALIPI]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALICM_DF]  DEFAULT ((0)) FOR [D2_VALICM]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_TES_DF]  DEFAULT ('   ') FOR [D2_TES]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CF_DF]  DEFAULT ('     ') FOR [D2_CF]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_DESC_DF]  DEFAULT ((0)) FOR [D2_DESC]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_IPI_DF]  DEFAULT ((0)) FOR [D2_IPI]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_PICM_DF]  DEFAULT ((0)) FOR [D2_PICM]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_PESO_DF]  DEFAULT ((0)) FOR [D2_PESO]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CONTA_DF]  DEFAULT ('                    ') FOR [D2_CONTA]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_OP_DF]  DEFAULT ('             ') FOR [D2_OP]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_PEDIDO_DF]  DEFAULT ('      ') FOR [D2_PEDIDO]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ITEMPV_DF]  DEFAULT ('  ') FOR [D2_ITEMPV]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CLIENTE_DF]  DEFAULT ('      ') FOR [D2_CLIENTE]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_LOJA_DF]  DEFAULT ('  ') FOR [D2_LOJA]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_LOCAL_DF]  DEFAULT ('  ') FOR [D2_LOCAL]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_DOC_DF]  DEFAULT ('         ') FOR [D2_DOC]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_SERIE_DF]  DEFAULT ('   ') FOR [D2_SERIE]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_GRUPO_DF]  DEFAULT ('    ') FOR [D2_GRUPO]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_TP_DF]  DEFAULT ('  ') FOR [D2_TP]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_EMISSAO_DF]  DEFAULT ('        ') FOR [D2_EMISSAO]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CUSTO1_DF]  DEFAULT ((0)) FOR [D2_CUSTO1]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CUSTO2_DF]  DEFAULT ((0)) FOR [D2_CUSTO2]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CUSTO3_DF]  DEFAULT ((0)) FOR [D2_CUSTO3]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CUSTO4_DF]  DEFAULT ((0)) FOR [D2_CUSTO4]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CUSTO5_DF]  DEFAULT ((0)) FOR [D2_CUSTO5]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_PRUNIT_DF]  DEFAULT ((0)) FOR [D2_PRUNIT]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_QTSEGUM_DF]  DEFAULT ((0)) FOR [D2_QTSEGUM]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_NUMSEQ_DF]  DEFAULT ('      ') FOR [D2_NUMSEQ]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_EST_DF]  DEFAULT ('  ') FOR [D2_EST]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_DESCON_DF]  DEFAULT ((0)) FOR [D2_DESCON]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_TIPO_DF]  DEFAULT (' ') FOR [D2_TIPO]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_NFORI_DF]  DEFAULT ('         ') FOR [D2_NFORI]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_SERIORI_DF]  DEFAULT ('   ') FOR [D2_SERIORI]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_QTDEDEV_DF]  DEFAULT ((0)) FOR [D2_QTDEDEV]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALDEV_DF]  DEFAULT ((0)) FOR [D2_VALDEV]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ORIGLAN_DF]  DEFAULT ('  ') FOR [D2_ORIGLAN]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BRICMS_DF]  DEFAULT ((0)) FOR [D2_BRICMS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASEORI_DF]  DEFAULT ((0)) FOR [D2_BASEORI]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASEICM_DF]  DEFAULT ((0)) FOR [D2_BASEICM]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALACRS_DF]  DEFAULT ((0)) FOR [D2_VALACRS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_IDENTB6_DF]  DEFAULT ('      ') FOR [D2_IDENTB6]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CODISS_DF]  DEFAULT ('         ') FOR [D2_CODISS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_GRADE_DF]  DEFAULT (' ') FOR [D2_GRADE]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_SEQCALC_DF]  DEFAULT ('              ') FOR [D2_SEQCALC]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ICMSRET_DF]  DEFAULT ((0)) FOR [D2_ICMSRET]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_COMIS1_DF]  DEFAULT ((0)) FOR [D2_COMIS1]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_COMIS2_DF]  DEFAULT ((0)) FOR [D2_COMIS2]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_COMIS3_DF]  DEFAULT ((0)) FOR [D2_COMIS3]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_COMIS4_DF]  DEFAULT ((0)) FOR [D2_COMIS4]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_COMIS5_DF]  DEFAULT ((0)) FOR [D2_COMIS5]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_LOTECTL_DF]  DEFAULT ('          ') FOR [D2_LOTECTL]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_NUMLOTE_DF]  DEFAULT ('      ') FOR [D2_NUMLOTE]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_DTVALID_DF]  DEFAULT ('        ') FOR [D2_DTVALID]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_DESCZFR_DF]  DEFAULT ((0)) FOR [D2_DESCZFR]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_PDV_DF]  DEFAULT ('          ') FOR [D2_PDV]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_NUMSERI_DF]  DEFAULT ('                    ') FOR [D2_NUMSERI]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_DTLCTCT_DF]  DEFAULT ('        ') FOR [D2_DTLCTCT]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CUSFF1_DF]  DEFAULT ((0)) FOR [D2_CUSFF1]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CUSFF2_DF]  DEFAULT ((0)) FOR [D2_CUSFF2]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CUSFF3_DF]  DEFAULT ((0)) FOR [D2_CUSFF3]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CUSFF4_DF]  DEFAULT ((0)) FOR [D2_CUSFF4]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CUSFF5_DF]  DEFAULT ((0)) FOR [D2_CUSFF5]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CLASFIS_DF]  DEFAULT ('   ') FOR [D2_CLASFIS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASIMP1_DF]  DEFAULT ((0)) FOR [D2_BASIMP1]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_REMITO_DF]  DEFAULT ('         ') FOR [D2_REMITO]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_SERIREM_DF]  DEFAULT ('   ') FOR [D2_SERIREM]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASIMP2_DF]  DEFAULT ((0)) FOR [D2_BASIMP2]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASIMP3_DF]  DEFAULT ((0)) FOR [D2_BASIMP3]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ITEMREM_DF]  DEFAULT ('  ') FOR [D2_ITEMREM]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASIMP4_DF]  DEFAULT ((0)) FOR [D2_BASIMP4]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASIMP5_DF]  DEFAULT ((0)) FOR [D2_BASIMP5]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASIMP6_DF]  DEFAULT ((0)) FOR [D2_BASIMP6]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALIMP1_DF]  DEFAULT ((0)) FOR [D2_VALIMP1]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALIMP2_DF]  DEFAULT ((0)) FOR [D2_VALIMP2]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALIMP3_DF]  DEFAULT ((0)) FOR [D2_VALIMP3]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALIMP4_DF]  DEFAULT ((0)) FOR [D2_VALIMP4]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALIMP5_DF]  DEFAULT ((0)) FOR [D2_VALIMP5]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALIMP6_DF]  DEFAULT ((0)) FOR [D2_VALIMP6]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ITEMORI_DF]  DEFAULT ('    ') FOR [D2_ITEMORI]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CODFAB_DF]  DEFAULT ('      ') FOR [D2_CODFAB]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_LOJAFA_DF]  DEFAULT ('  ') FOR [D2_LOJAFA]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALQIMP1_DF]  DEFAULT ((0)) FOR [D2_ALQIMP1]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALQIMP2_DF]  DEFAULT ((0)) FOR [D2_ALQIMP2]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALQIMP3_DF]  DEFAULT ((0)) FOR [D2_ALQIMP3]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALQIMP4_DF]  DEFAULT ((0)) FOR [D2_ALQIMP4]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALQIMP5_DF]  DEFAULT ((0)) FOR [D2_ALQIMP5]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALQIMP6_DF]  DEFAULT ((0)) FOR [D2_ALQIMP6]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CCUSTO_DF]  DEFAULT ('         ') FOR [D2_CCUSTO]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ITEMCC_DF]  DEFAULT ('           ') FOR [D2_ITEMCC]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_LOCALIZ_DF]  DEFAULT ('               ') FOR [D2_LOCALIZ]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ENVCNAB_DF]  DEFAULT ('        ') FOR [D2_ENVCNAB]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALIQINS_DF]  DEFAULT ((0)) FOR [D2_ALIQINS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ABSCINS_DF]  DEFAULT ((0)) FOR [D2_ABSCINS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_PREEMB_DF]  DEFAULT ('                    ') FOR [D2_PREEMB]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALIQISS_DF]  DEFAULT ((0)) FOR [D2_ALIQISS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASEIPI_DF]  DEFAULT ((0)) FOR [D2_BASEIPI]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASEISS_DF]  DEFAULT ((0)) FOR [D2_BASEISS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALISS_DF]  DEFAULT ((0)) FOR [D2_VALISS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_SEGURO_DF]  DEFAULT ((0)) FOR [D2_SEGURO]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALFRE_DF]  DEFAULT ((0)) FOR [D2_VALFRE]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_TPDCENV_DF]  DEFAULT (' ') FOR [D2_TPDCENV]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_DESPESA_DF]  DEFAULT ((0)) FOR [D2_DESPESA]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_OK_DF]  DEFAULT ('  ') FOR [D2_OK]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CLVL_DF]  DEFAULT ('                    ') FOR [D2_CLVL]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASEINS_DF]  DEFAULT ((0)) FOR [D2_BASEINS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ICMFRET_DF]  DEFAULT ((0)) FOR [D2_ICMFRET]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_SERVIC_DF]  DEFAULT ('   ') FOR [D2_SERVIC]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_STSERV_DF]  DEFAULT (' ') FOR [D2_STSERV]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALINS_DF]  DEFAULT ((0)) FOR [D2_VALINS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_PROJPMS_DF]  DEFAULT ('          ') FOR [D2_PROJPMS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_EDTPMS_DF]  DEFAULT ('            ') FOR [D2_EDTPMS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_TASKPMS_DF]  DEFAULT ('            ') FOR [D2_TASKPMS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_LICITA_DF]  DEFAULT ('      ') FOR [D2_LICITA]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VARPRUN_DF]  DEFAULT ((0)) FOR [D2_VARPRUN]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_FORMUL_DF]  DEFAULT (' ') FOR [D2_FORMUL]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_TIPODOC_DF]  DEFAULT ('  ') FOR [D2_TIPODOC]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VAC_DF]  DEFAULT ((0)) FOR [D2_VAC]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_TIPOREM_DF]  DEFAULT (' ') FOR [D2_TIPOREM]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_QTDEFAT_DF]  DEFAULT ((0)) FOR [D2_QTDEFAT]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_QTDAFAT_DF]  DEFAULT ((0)) FOR [D2_QTDAFAT]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_SEQUEN_DF]  DEFAULT ('  ') FOR [D2_SEQUEN]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_POTENCI_DF]  DEFAULT ((0)) FOR [D2_POTENCI]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_TPESTR_DF]  DEFAULT ('      ') FOR [D2_TPESTR]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALBRUT_DF]  DEFAULT ((0)) FOR [D2_VALBRUT]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_REGWMS_DF]  DEFAULT (' ') FOR [D2_REGWMS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_DTDIGIT_DF]  DEFAULT ('        ') FOR [D2_DTDIGIT]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_NUMCP_DF]  DEFAULT ('      ') FOR [D2_NUMCP]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASEPS3_DF]  DEFAULT ((0)) FOR [D2_BASEPS3]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALIQPS3_DF]  DEFAULT ((0)) FOR [D2_ALIQPS3]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALPS3_DF]  DEFAULT ((0)) FOR [D2_VALPS3]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASECF3_DF]  DEFAULT ((0)) FOR [D2_BASECF3]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALIQCF3_DF]  DEFAULT ((0)) FOR [D2_ALIQCF3]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALCF3_DF]  DEFAULT ((0)) FOR [D2_VALCF3]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_DESCICM_DF]  DEFAULT ((0)) FOR [D2_DESCICM]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CFPS_DF]  DEFAULT ('      ') FOR [D2_CFPS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASETST_DF]  DEFAULT ((0)) FOR [D2_BASETST]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALIQTST_DF]  DEFAULT ((0)) FOR [D2_ALIQTST]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALTST_DF]  DEFAULT ((0)) FOR [D2_VALTST]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ESTCRED_DF]  DEFAULT ((0)) FOR [D2_ESTCRED]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALFDS_DF]  DEFAULT ((0)) FOR [D2_VALFDS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_PRFDSUL_DF]  DEFAULT ((0)) FOR [D2_PRFDSUL]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_UFERMS_DF]  DEFAULT ((0)) FOR [D2_UFERMS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ABATISS_DF]  DEFAULT ((0)) FOR [D2_ABATISS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ABATMAT_DF]  DEFAULT ((0)) FOR [D2_ABATMAT]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASEIRR_DF]  DEFAULT ((0)) FOR [D2_BASEIRR]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CODROM_DF]  DEFAULT ('      ') FOR [D2_CODROM]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_PRUNDA_DF]  DEFAULT ((0)) FOR [D2_PRUNDA]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_TRT_DF]  DEFAULT ('   ') FOR [D2_TRT]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D_E_L_E_T__DF]  DEFAULT (' ') FOR [D_E_L_E_T_]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_R_E_C_N_O__DF]  DEFAULT ((0)) FOR [R_E_C_N_O_]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_R_E_C_D_E_L__DF]  DEFAULT ((0)) FOR [R_E_C_D_E_L_]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALIQSOL_DF]  DEFAULT ((0)) FOR [D2_ALIQSOL]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2__TOTAL_DF]  DEFAULT ((0)) FOR [D2__TOTAL]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CRPRESC_DF]  DEFAULT ((0)) FOR [D2_CRPRESC]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_DESCZFP_DF]  DEFAULT ((0)) FOR [D2_DESCZFP]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_DESCZFC_DF]  DEFAULT ((0)) FOR [D2_DESCZFC]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASEFAB_DF]  DEFAULT ((0)) FOR [D2_BASEFAB]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALIQFAB_DF]  DEFAULT ((0)) FOR [D2_ALIQFAB]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALFAB_DF]  DEFAULT ((0)) FOR [D2_VALFAB]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASEFAC_DF]  DEFAULT ((0)) FOR [D2_BASEFAC]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALIQFAC_DF]  DEFAULT ((0)) FOR [D2_ALIQFAC]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALFAC_DF]  DEFAULT ((0)) FOR [D2_VALFAC]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASEFET_DF]  DEFAULT ((0)) FOR [D2_BASEFET]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALIQFET_DF]  DEFAULT ((0)) FOR [D2_ALIQFET]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALFET_DF]  DEFAULT ((0)) FOR [D2_VALFET]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_MARGEM_DF]  DEFAULT ((0)) FOR [D2_MARGEM]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_X_FLGIM_DF]  DEFAULT (' ') FOR [D2_X_FLGIM]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASEFUN_DF]  DEFAULT ((0)) FOR [D2_BASEFUN]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_DFABRIC_DF]  DEFAULT ('        ') FOR [D2_DFABRIC]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALIQFUN_DF]  DEFAULT ((0)) FOR [D2_ALIQFUN]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALFUN_DF]  DEFAULT ((0)) FOR [D2_VALFUN]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ABATINS_DF]  DEFAULT ((0)) FOR [D2_ABATINS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VLSENAR_DF]  DEFAULT ((0)) FOR [D2_VLSENAR]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BSSENAR_DF]  DEFAULT ((0)) FOR [D2_BSSENAR]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALSENAR_DF]  DEFAULT ((0)) FOR [D2_ALSENAR]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CODLAN_DF]  DEFAULT ('      ') FOR [D2_CODLAN]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_X_PMSZN_DF]  DEFAULT ((0)) FOR [D2_X_PMSZN]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_X_PRUNI_DF]  DEFAULT ((0)) FOR [D2_X_PRUNI]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALINA_DF]  DEFAULT ((0)) FOR [D2_VALINA]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASEINA_DF]  DEFAULT ((0)) FOR [D2_BASEINA]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALIQINA_DF]  DEFAULT ((0)) FOR [D2_ALIQINA]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_TNATREC_DF]  DEFAULT ('    ') FOR [D2_TNATREC]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CNATREC_DF]  DEFAULT ('   ') FOR [D2_CNATREC]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_GRUPONC_DF]  DEFAULT ('  ') FOR [D2_GRUPONC]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_DTFIMNT_DF]  DEFAULT ('        ') FOR [D2_DTFIMNT]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASEPIS_DF]  DEFAULT ((0)) FOR [D2_BASEPIS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASECOF_DF]  DEFAULT ((0)) FOR [D2_BASECOF]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASECSL_DF]  DEFAULT ((0)) FOR [D2_BASECSL]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALPIS_DF]  DEFAULT ((0)) FOR [D2_VALPIS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALCOF_DF]  DEFAULT ((0)) FOR [D2_VALCOF]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALCSL_DF]  DEFAULT ((0)) FOR [D2_VALCSL]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALQPIS_DF]  DEFAULT ((0)) FOR [D2_ALQPIS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALQCOF_DF]  DEFAULT ((0)) FOR [D2_ALQCOF]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALQCSL_DF]  DEFAULT ((0)) FOR [D2_ALQCSL]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VLINCMG_DF]  DEFAULT ((0)) FOR [D2_VLINCMG]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_PRINCMG_DF]  DEFAULT ((0)) FOR [D2_PRINCMG]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CBASEAF_DF]  DEFAULT ('              ') FOR [D2_CBASEAF]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VCAT156_DF]  DEFAULT ((0)) FOR [D2_VCAT156]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VREINT_DF]  DEFAULT ((0)) FOR [D2_VREINT]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BSREIN_DF]  DEFAULT ((0)) FOR [D2_BSREIN]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_09CAT17_DF]  DEFAULT ((0)) FOR [D2_09CAT17]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_16CAT17_DF]  DEFAULT ((0)) FOR [D2_16CAT17]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_FCICOD_DF]  DEFAULT ('                                    ') FOR [D2_FCICOD]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CUSRP1_DF]  DEFAULT ((0)) FOR [D2_CUSRP1]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CUSRP2_DF]  DEFAULT ((0)) FOR [D2_CUSRP2]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CUSRP3_DF]  DEFAULT ((0)) FOR [D2_CUSRP3]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CUSRP4_DF]  DEFAULT ((0)) FOR [D2_CUSRP4]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CUSRP5_DF]  DEFAULT ((0)) FOR [D2_CUSRP5]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALIRRF_DF]  DEFAULT ((0)) FOR [D2_VALIRRF]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALQIRRF_DF]  DEFAULT ((0)) FOR [D2_ALQIRRF]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ORDSEP_DF]  DEFAULT ('      ') FOR [D2_ORDSEP]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_RATEIO_DF]  DEFAULT (' ') FOR [D2_RATEIO]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CODLPRE_DF]  DEFAULT ('      ') FOR [D2_CODLPRE]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ITLPRE_DF]  DEFAULT ('   ') FOR [D2_ITLPRE]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_SITTRIB_DF]  DEFAULT ('     ') FOR [D2_SITTRIB]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VLIMPOR_DF]  DEFAULT ((0)) FOR [D2_VLIMPOR]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_OKISS_DF]  DEFAULT ('          ') FOR [D2_OKISS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_TOTIMP_DF]  DEFAULT ((0)) FOR [D2_TOTIMP]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_IDCFC_DF]  DEFAULT ('                    ') FOR [D2_IDCFC]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_TOTFED_DF]  DEFAULT ((0)) FOR [D2_TOTFED]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_TOTEST_DF]  DEFAULT ((0)) FOR [D2_TOTEST]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_TOTMUN_DF]  DEFAULT ((0)) FOR [D2_TOTMUN]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALCPM_DF]  DEFAULT ((0)) FOR [D2_VALCPM]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASECPM_DF]  DEFAULT ((0)) FOR [D2_BASECPM]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALQCPM_DF]  DEFAULT ((0)) FOR [D2_ALQCPM]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALFMP_DF]  DEFAULT ((0)) FOR [D2_VALFMP]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASEFMP_DF]  DEFAULT ((0)) FOR [D2_BASEFMP]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALQFMP_DF]  DEFAULT ((0)) FOR [D2_ALQFMP]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASEFMD_DF]  DEFAULT ((0)) FOR [D2_BASEFMD]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALQFMD_DF]  DEFAULT ((0)) FOR [D2_ALQFMD]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALFMD_DF]  DEFAULT ((0)) FOR [D2_VALFMD]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ESPECIE_DF]  DEFAULT ('     ') FOR [D2_ESPECIE]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_NFCUP_DF]  DEFAULT ('         ') FOR [D2_NFCUP]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ESTOQUE_DF]  DEFAULT (' ') FOR [D2_ESTOQUE]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_IDSF7_DF]  DEFAULT ('                    ') FOR [D2_IDSF7]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_IDSF4_DF]  DEFAULT ('                    ') FOR [D2_IDSF4]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_IDSBZ_DF]  DEFAULT ('                    ') FOR [D2_IDSBZ]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_IDSB5_DF]  DEFAULT ('                    ') FOR [D2_IDSB5]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_IDSB1_DF]  DEFAULT ('                    ') FOR [D2_IDSB1]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_PRODFIN_DF]  DEFAULT ('               ') FOR [D2_PRODFIN]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_REVISAO_DF]  DEFAULT ('   ') FOR [D2_REVISAO]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_GRPCST_DF]  DEFAULT ('   ') FOR [D2_GRPCST]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASECPB_DF]  DEFAULT ((0)) FOR [D2_BASECPB]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALCPB_DF]  DEFAULT ((0)) FOR [D2_VALCPB]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALIQCPB_DF]  DEFAULT ((0)) FOR [D2_ALIQCPB]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ICMSCOM_DF]  DEFAULT ((0)) FOR [D2_ICMSCOM]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_DIFAL_DF]  DEFAULT ((0)) FOR [D2_DIFAL]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_PDORI_DF]  DEFAULT ((0)) FOR [D2_PDORI]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_PDDES_DF]  DEFAULT ((0)) FOR [D2_PDDES]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALFCCMP_DF]  DEFAULT ((0)) FOR [D2_ALFCCMP]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALIQCMP_DF]  DEFAULT ((0)) FOR [D2_ALIQCMP]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASEDES_DF]  DEFAULT ((0)) FOR [D2_BASEDES]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VFCPDIF_DF]  DEFAULT ((0)) FOR [D2_VFCPDIF]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_FTRICMS_DF]  DEFAULT ((0)) FOR [D2_FTRICMS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VRDICMS_DF]  DEFAULT ((0)) FOR [D2_VRDICMS]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALFUND_DF]  DEFAULT ((0)) FOR [D2_VALFUND]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASFUND_DF]  DEFAULT ((0)) FOR [D2_BASFUND]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALIFUND_DF]  DEFAULT ((0)) FOR [D2_ALIFUND]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALIMA_DF]  DEFAULT ((0)) FOR [D2_VALIMA]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASIMA_DF]  DEFAULT ((0)) FOR [D2_BASIMA]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALIIMA_DF]  DEFAULT ((0)) FOR [D2_ALIIMA]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALFASE_DF]  DEFAULT ((0)) FOR [D2_VALFASE]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_BASFASE_DF]  DEFAULT ((0)) FOR [D2_BASFASE]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALIFASE_DF]  DEFAULT ((0)) FOR [D2_ALIFASE]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_INDICE_DF]  DEFAULT ((0)) FOR [D2_INDICE]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_CSOSN_DF]  DEFAULT ('   ') FOR [D2_CSOSN]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_ALQFECP_DF]  DEFAULT ((0)) FOR [D2_ALQFECP]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VALFECP_DF]  DEFAULT ((0)) FOR [D2_VALFECP]
GO
ALTER TABLE [dbo].[SD2010] ADD  CONSTRAINT [SD2010_D2_VFECPST_DF]  DEFAULT ((0)) FOR [D2_VFECPST]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_FILIAL_DF]  DEFAULT ('  ') FOR [F1_FILIAL]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_DOC_DF]  DEFAULT ('         ') FOR [F1_DOC]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_SERIE_DF]  DEFAULT ('   ') FOR [F1_SERIE]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_FORNECE_DF]  DEFAULT ('      ') FOR [F1_FORNECE]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_LOJA_DF]  DEFAULT ('  ') FOR [F1_LOJA]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_COND_DF]  DEFAULT ('   ') FOR [F1_COND]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_DUPL_DF]  DEFAULT ('         ') FOR [F1_DUPL]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_EMISSAO_DF]  DEFAULT ('        ') FOR [F1_EMISSAO]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_EST_DF]  DEFAULT ('  ') FOR [F1_EST]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_FRETE_DF]  DEFAULT ((0)) FOR [F1_FRETE]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_DESPESA_DF]  DEFAULT ((0)) FOR [F1_DESPESA]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_BASEICM_DF]  DEFAULT ((0)) FOR [F1_BASEICM]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALICM_DF]  DEFAULT ((0)) FOR [F1_VALICM]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_BASEIPI_DF]  DEFAULT ((0)) FOR [F1_BASEIPI]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALIPI_DF]  DEFAULT ((0)) FOR [F1_VALIPI]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALMERC_DF]  DEFAULT ((0)) FOR [F1_VALMERC]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALBRUT_DF]  DEFAULT ((0)) FOR [F1_VALBRUT]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_TIPO_DF]  DEFAULT (' ') FOR [F1_TIPO]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_DESCONT_DF]  DEFAULT ((0)) FOR [F1_DESCONT]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_DTDIGIT_DF]  DEFAULT ('        ') FOR [F1_DTDIGIT]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_CPROVA_DF]  DEFAULT ('              ') FOR [F1_CPROVA]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_BRICMS_DF]  DEFAULT ((0)) FOR [F1_BRICMS]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_ICMSRET_DF]  DEFAULT ((0)) FOR [F1_ICMSRET]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_BASEFD_DF]  DEFAULT ((0)) FOR [F1_BASEFD]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_DTLANC_DF]  DEFAULT ('        ') FOR [F1_DTLANC]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_OK_DF]  DEFAULT ('  ') FOR [F1_OK]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_ORIGLAN_DF]  DEFAULT ('  ') FOR [F1_ORIGLAN]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_TX_DF]  DEFAULT (' ') FOR [F1_TX]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_CONTSOC_DF]  DEFAULT ((0)) FOR [F1_CONTSOC]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_IRRF_DF]  DEFAULT ((0)) FOR [F1_IRRF]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_FORMUL_DF]  DEFAULT (' ') FOR [F1_FORMUL]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_NFORIG_DF]  DEFAULT ('         ') FOR [F1_NFORIG]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_SERORIG_DF]  DEFAULT ('   ') FOR [F1_SERORIG]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_ESPECIE_DF]  DEFAULT ('     ') FOR [F1_ESPECIE]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_IMPORT_DF]  DEFAULT (' ') FOR [F1_IMPORT]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_II_DF]  DEFAULT ((0)) FOR [F1_II]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_REMITO_DF]  DEFAULT ('         ') FOR [F1_REMITO]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_BASIMP2_DF]  DEFAULT ((0)) FOR [F1_BASIMP2]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_BASIMP3_DF]  DEFAULT ((0)) FOR [F1_BASIMP3]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_BASIMP4_DF]  DEFAULT ((0)) FOR [F1_BASIMP4]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_BASIMP5_DF]  DEFAULT ((0)) FOR [F1_BASIMP5]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_BASIMP6_DF]  DEFAULT ((0)) FOR [F1_BASIMP6]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALIMP1_DF]  DEFAULT ((0)) FOR [F1_VALIMP1]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALIMP2_DF]  DEFAULT ((0)) FOR [F1_VALIMP2]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALIMP3_DF]  DEFAULT ((0)) FOR [F1_VALIMP3]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALIMP4_DF]  DEFAULT ((0)) FOR [F1_VALIMP4]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALIMP5_DF]  DEFAULT ((0)) FOR [F1_VALIMP5]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALIMP6_DF]  DEFAULT ((0)) FOR [F1_VALIMP6]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_ORDPAGO_DF]  DEFAULT ('      ') FOR [F1_ORDPAGO]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_HORA_DF]  DEFAULT ('        ') FOR [F1_HORA]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_INSS_DF]  DEFAULT ((0)) FOR [F1_INSS]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_ISS_DF]  DEFAULT ((0)) FOR [F1_ISS]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_BASIMP1_DF]  DEFAULT ((0)) FOR [F1_BASIMP1]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_HAWB_DF]  DEFAULT ('                 ') FOR [F1_HAWB]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_TIPO_NF_DF]  DEFAULT (' ') FOR [F1_TIPO_NF]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_IPI_DF]  DEFAULT ((0)) FOR [F1_IPI]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_ICMS_DF]  DEFAULT ((0)) FOR [F1_ICMS]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_PESOL_DF]  DEFAULT ((0)) FOR [F1_PESOL]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_FOB_R_DF]  DEFAULT ((0)) FOR [F1_FOB_R]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_SEGURO_DF]  DEFAULT ((0)) FOR [F1_SEGURO]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_CIF_DF]  DEFAULT ((0)) FOR [F1_CIF]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_MOEDA_DF]  DEFAULT ((0)) FOR [F1_MOEDA]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_PREFIXO_DF]  DEFAULT ('   ') FOR [F1_PREFIXO]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_STATUS_DF]  DEFAULT (' ') FOR [F1_STATUS]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALEMB_DF]  DEFAULT ((0)) FOR [F1_VALEMB]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_RECBMTO_DF]  DEFAULT ('        ') FOR [F1_RECBMTO]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_CTR_NFC_DF]  DEFAULT ('            ') FOR [F1_CTR_NFC]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_APROV_DF]  DEFAULT ('      ') FOR [F1_APROV]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_TXMOEDA_DF]  DEFAULT ((0)) FOR [F1_TXMOEDA]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_PEDVEND_DF]  DEFAULT ('      ') FOR [F1_PEDVEND]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_TIPODOC_DF]  DEFAULT ('  ') FOR [F1_TIPODOC]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_TIPOREM_DF]  DEFAULT (' ') FOR [F1_TIPOREM]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_GNR_DF]  DEFAULT ('      ') FOR [F1_GNR]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALPIS_DF]  DEFAULT ((0)) FOR [F1_VALPIS]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALCOFI_DF]  DEFAULT ((0)) FOR [F1_VALCOFI]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALCSLL_DF]  DEFAULT ((0)) FOR [F1_VALCSLL]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_BASEPS3_DF]  DEFAULT ((0)) FOR [F1_BASEPS3]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALPS3_DF]  DEFAULT ((0)) FOR [F1_VALPS3]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_BASECF3_DF]  DEFAULT ((0)) FOR [F1_BASECF3]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALCF3_DF]  DEFAULT ((0)) FOR [F1_VALCF3]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_NFELETR_DF]  DEFAULT ('                    ') FOR [F1_NFELETR]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_EMINFE_DF]  DEFAULT ('        ') FOR [F1_EMINFE]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_HORNFE_DF]  DEFAULT ('        ') FOR [F1_HORNFE]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_CODNFE_DF]  DEFAULT ('                                                  ') FOR [F1_CODNFE]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_CREDNFE_DF]  DEFAULT ((0)) FOR [F1_CREDNFE]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VNAGREG_DF]  DEFAULT ((0)) FOR [F1_VNAGREG]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_NUMRPS_DF]  DEFAULT ('            ') FOR [F1_NUMRPS]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALIRF_DF]  DEFAULT ((0)) FOR [F1_VALIRF]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_NUMMOV_DF]  DEFAULT ('  ') FOR [F1_NUMMOV]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_CHVNFE_DF]  DEFAULT ('                                            ') FOR [F1_CHVNFE]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_RECISS_DF]  DEFAULT (' ') FOR [F1_RECISS]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_FILORIG_DF]  DEFAULT ('  ') FOR [F1_FILORIG]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_NODIA_DF]  DEFAULT ('          ') FOR [F1_NODIA]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_ESTCRED_DF]  DEFAULT ((0)) FOR [F1_ESTCRED]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_DIACTB_DF]  DEFAULT ('  ') FOR [F1_DIACTB]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_NUMRA_DF]  DEFAULT ('      ') FOR [F1_NUMRA]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_BASEINS_DF]  DEFAULT ((0)) FOR [F1_BASEINS]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALFDS_DF]  DEFAULT ((0)) FOR [F1_VALFDS]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_TRANSP_DF]  DEFAULT ('      ') FOR [F1_TRANSP]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_PLIQUI_DF]  DEFAULT ((0)) FOR [F1_PLIQUI]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_PBRUTO_DF]  DEFAULT ((0)) FOR [F1_PBRUTO]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_ESPECI1_DF]  DEFAULT ('          ') FOR [F1_ESPECI1]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VOLUME1_DF]  DEFAULT ((0)) FOR [F1_VOLUME1]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_ESPECI2_DF]  DEFAULT ('          ') FOR [F1_ESPECI2]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VOLUME2_DF]  DEFAULT ((0)) FOR [F1_VOLUME2]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_ESPECI3_DF]  DEFAULT ('          ') FOR [F1_ESPECI3]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VOLUME3_DF]  DEFAULT ((0)) FOR [F1_VOLUME3]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_ESPECI4_DF]  DEFAULT ('          ') FOR [F1_ESPECI4]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VOLUME4_DF]  DEFAULT ((0)) FOR [F1_VOLUME4]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_D_E_L_E_T__DF]  DEFAULT (' ') FOR [D_E_L_E_T_]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_R_E_C_N_O__DF]  DEFAULT ((0)) FOR [R_E_C_N_O_]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_R_E_C_D_E_L__DF]  DEFAULT ((0)) FOR [R_E_C_D_E_L_]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_PLACA_DF]  DEFAULT ('        ') FOR [F1_PLACA]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_DOCFOL_DF]  DEFAULT ('         ') FOR [F1_DOCFOL]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VERBAFO_DF]  DEFAULT ('         ') FOR [F1_VERBAFO]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_TPNFEXP_DF]  DEFAULT (' ') FOR [F1_TPNFEXP]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_X_BLOQ_DF]  DEFAULT (' ') FOR [F1_X_BLOQ]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1__ICMRET_DF]  DEFAULT ((0)) FOR [F1__ICMRET]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_TPFRETE_DF]  DEFAULT (' ') FOR [F1_TPFRETE]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_FIMP_DF]  DEFAULT (' ') FOR [F1_FIMP]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALFAB_DF]  DEFAULT ((0)) FOR [F1_VALFAB]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALFAC_DF]  DEFAULT ((0)) FOR [F1_VALFAC]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALFET_DF]  DEFAULT ((0)) FOR [F1_VALFET]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_BASEFUN_DF]  DEFAULT ((0)) FOR [F1_BASEFUN]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALPEDG_DF]  DEFAULT ((0)) FOR [F1_VALPEDG]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_FORRET_DF]  DEFAULT ('      ') FOR [F1_FORRET]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_LOJARET_DF]  DEFAULT ('  ') FOR [F1_LOJARET]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_RECOPI_DF]  DEFAULT (' ') FOR [F1_RECOPI]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALINA_DF]  DEFAULT ((0)) FOR [F1_VALINA]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_BASEINA_DF]  DEFAULT ((0)) FOR [F1_BASEINA]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_BASPIS_DF]  DEFAULT ((0)) FOR [F1_BASPIS]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_BASCOFI_DF]  DEFAULT ((0)) FOR [F1_BASCOFI]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_BASCSLL_DF]  DEFAULT ((0)) FOR [F1_BASCSLL]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_TPCTE_DF]  DEFAULT (' ') FOR [F1_TPCTE]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VLSENAR_DF]  DEFAULT ((0)) FOR [F1_VLSENAR]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_NUMAIDF_DF]  DEFAULT ('       ') FOR [F1_NUMAIDF]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_ANOAIDF_DF]  DEFAULT ('    ') FOR [F1_ANOAIDF]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_EVENFLG_DF]  DEFAULT (' ') FOR [F1_EVENFLG]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_IDCCE_DF]  DEFAULT ('                                                      ') FOR [F1_IDCCE]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_FLAGRGS_DF]  DEFAULT ('    ') FOR [F1_FLAGRGS]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_IDRGS_DF]  DEFAULT ('                                                      ') FOR [F1_IDRGS]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_CODRGS_DF]  DEFAULT (' ') FOR [F1_CODRGS]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_DAUTNFE_DF]  DEFAULT ('        ') FOR [F1_DAUTNFE]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_HAUTNFE_DF]  DEFAULT ('     ') FOR [F1_HAUTNFE]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_MENNOTA_DF]  DEFAULT ('                                                            ') FOR [F1_MENNOTA]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_MENPAD_DF]  DEFAULT ('   ') FOR [F1_MENPAD]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_FORENT_DF]  DEFAULT ('      ') FOR [F1_FORENT]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_LOJAENT_DF]  DEFAULT ('  ') FOR [F1_LOJAENT]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_STATCON_DF]  DEFAULT (' ') FOR [F1_STATCON]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_MSIDENT_DF]  DEFAULT ('          ') FOR [F1_MSIDENT]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_QTDCONF_DF]  DEFAULT ((0)) FOR [F1_QTDCONF]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_NUMTRIB_DF]  DEFAULT ('         ') FOR [F1_NUMTRIB]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_INCISS_DF]  DEFAULT ('     ') FOR [F1_INCISS]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_ESTPRES_DF]  DEFAULT ('  ') FOR [F1_ESTPRES]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_IDRECOP_DF]  DEFAULT ('      ') FOR [F1_IDRECOP]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VLCIDE_DF]  DEFAULT ((0)) FOR [F1_VLCIDE]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_BASECID_DF]  DEFAULT ((0)) FOR [F1_BASECID]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VLCPM_DF]  DEFAULT ((0)) FOR [F1_VLCPM]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_BASECPM_DF]  DEFAULT ((0)) FOR [F1_BASECPM]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALFMD_DF]  DEFAULT ((0)) FOR [F1_VALFMD]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_LOJAORI_DF]  DEFAULT ('  ') FOR [F1_LOJAORI]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_CLIORI_DF]  DEFAULT ('      ') FOR [F1_CLIORI]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_IDSED_DF]  DEFAULT ('                    ') FOR [F1_IDSED]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_IDSA2_DF]  DEFAULT ('                    ') FOR [F1_IDSA2]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_IDSA1_DF]  DEFAULT ('                    ') FOR [F1_IDSA1]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_DTCPISS_DF]  DEFAULT ('        ') FOR [F1_DTCPISS]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALFMP_DF]  DEFAULT ((0)) FOR [F1_VALFMP]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_BASEFMP_DF]  DEFAULT ((0)) FOR [F1_BASEFMP]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_CLIDEST_DF]  DEFAULT ('      ') FOR [F1_CLIDEST]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_LOJDEST_DF]  DEFAULT ('  ') FOR [F1_LOJDEST]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_ESTDES_DF]  DEFAULT ('  ') FOR [F1_ESTDES]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALFUND_DF]  DEFAULT ((0)) FOR [F1_VALFUND]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALIMA_DF]  DEFAULT ((0)) FOR [F1_VALIMA]
GO
ALTER TABLE [dbo].[SF1010] ADD  CONSTRAINT [SF1010_F1_VALFASE_DF]  DEFAULT ((0)) FOR [F1_VALFASE]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_DOC_DF]  DEFAULT ('         ') FOR [F2_DOC]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_SERIE_DF]  DEFAULT ('   ') FOR [F2_SERIE]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_CLIENTE_DF]  DEFAULT ('      ') FOR [F2_CLIENTE]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_LOJA_DF]  DEFAULT ('  ') FOR [F2_LOJA]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_COND_DF]  DEFAULT ('   ') FOR [F2_COND]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_DUPL_DF]  DEFAULT ('         ') FOR [F2_DUPL]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_EMISSAO_DF]  DEFAULT ('        ') FOR [F2_EMISSAO]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_EST_DF]  DEFAULT ('  ') FOR [F2_EST]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_FRETE_DF]  DEFAULT ((0)) FOR [F2_FRETE]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_SEGURO_DF]  DEFAULT ((0)) FOR [F2_SEGURO]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_ICMFRET_DF]  DEFAULT ((0)) FOR [F2_ICMFRET]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_TIPOCLI_DF]  DEFAULT (' ') FOR [F2_TIPOCLI]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALBRUT_DF]  DEFAULT ((0)) FOR [F2_VALBRUT]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALICM_DF]  DEFAULT ((0)) FOR [F2_VALICM]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_BASEICM_DF]  DEFAULT ((0)) FOR [F2_BASEICM]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALIPI_DF]  DEFAULT ((0)) FOR [F2_VALIPI]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_BASEIPI_DF]  DEFAULT ((0)) FOR [F2_BASEIPI]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALMERC_DF]  DEFAULT ((0)) FOR [F2_VALMERC]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_NFORI_DF]  DEFAULT ('         ') FOR [F2_NFORI]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_DESCONT_DF]  DEFAULT ((0)) FOR [F2_DESCONT]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_SERIORI_DF]  DEFAULT ('   ') FOR [F2_SERIORI]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_TIPO_DF]  DEFAULT (' ') FOR [F2_TIPO]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_ESPECI1_DF]  DEFAULT ('          ') FOR [F2_ESPECI1]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_ESPECI2_DF]  DEFAULT ('          ') FOR [F2_ESPECI2]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_ESPECI3_DF]  DEFAULT ('          ') FOR [F2_ESPECI3]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_ESPECI4_DF]  DEFAULT ('          ') FOR [F2_ESPECI4]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VOLUME1_DF]  DEFAULT ((0)) FOR [F2_VOLUME1]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VOLUME2_DF]  DEFAULT ((0)) FOR [F2_VOLUME2]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VOLUME3_DF]  DEFAULT ((0)) FOR [F2_VOLUME3]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VOLUME4_DF]  DEFAULT ((0)) FOR [F2_VOLUME4]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_ICMSRET_DF]  DEFAULT ((0)) FOR [F2_ICMSRET]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_PLIQUI_DF]  DEFAULT ((0)) FOR [F2_PLIQUI]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_PBRUTO_DF]  DEFAULT ((0)) FOR [F2_PBRUTO]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_TRANSP_DF]  DEFAULT ('      ') FOR [F2_TRANSP]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_REDESP_DF]  DEFAULT ('      ') FOR [F2_REDESP]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VEND1_DF]  DEFAULT ('      ') FOR [F2_VEND1]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VEND2_DF]  DEFAULT ('      ') FOR [F2_VEND2]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VEND3_DF]  DEFAULT ('      ') FOR [F2_VEND3]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VEND4_DF]  DEFAULT ('      ') FOR [F2_VEND4]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VEND5_DF]  DEFAULT ('      ') FOR [F2_VEND5]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_OK_DF]  DEFAULT ('    ') FOR [F2_OK]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_FIMP_DF]  DEFAULT (' ') FOR [F2_FIMP]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_DTLANC_DF]  DEFAULT ('        ') FOR [F2_DTLANC]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_DTREAJ_DF]  DEFAULT ('        ') FOR [F2_DTREAJ]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_REAJUST_DF]  DEFAULT ('   ') FOR [F2_REAJUST]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_DTBASE0_DF]  DEFAULT ('        ') FOR [F2_DTBASE0]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_FATORB0_DF]  DEFAULT ((0)) FOR [F2_FATORB0]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_DTBASE1_DF]  DEFAULT ('        ') FOR [F2_DTBASE1]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_FATORB1_DF]  DEFAULT ((0)) FOR [F2_FATORB1]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VARIAC_DF]  DEFAULT ((0)) FOR [F2_VARIAC]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_FILIAL_DF]  DEFAULT ('  ') FOR [F2_FILIAL]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_BASEISS_DF]  DEFAULT ((0)) FOR [F2_BASEISS]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALISS_DF]  DEFAULT ((0)) FOR [F2_VALISS]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALFAT_DF]  DEFAULT ((0)) FOR [F2_VALFAT]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_CONTSOC_DF]  DEFAULT ((0)) FOR [F2_CONTSOC]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_BRICMS_DF]  DEFAULT ((0)) FOR [F2_BRICMS]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_FRETAUT_DF]  DEFAULT ((0)) FOR [F2_FRETAUT]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_ICMAUTO_DF]  DEFAULT ((0)) FOR [F2_ICMAUTO]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_DESPESA_DF]  DEFAULT ((0)) FOR [F2_DESPESA]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_NEXTSER_DF]  DEFAULT ('   ') FOR [F2_NEXTSER]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_NEXTDOC_DF]  DEFAULT ('         ') FOR [F2_NEXTDOC]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_ESPECIE_DF]  DEFAULT ('     ') FOR [F2_ESPECIE]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_PDV_DF]  DEFAULT ('          ') FOR [F2_PDV]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_MAPA_DF]  DEFAULT ('          ') FOR [F2_MAPA]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_ECF_DF]  DEFAULT (' ') FOR [F2_ECF]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_PREFIXO_DF]  DEFAULT ('   ') FOR [F2_PREFIXO]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_BASIMP1_DF]  DEFAULT ((0)) FOR [F2_BASIMP1]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_BASIMP2_DF]  DEFAULT ((0)) FOR [F2_BASIMP2]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_BASIMP3_DF]  DEFAULT ((0)) FOR [F2_BASIMP3]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_BASIMP4_DF]  DEFAULT ((0)) FOR [F2_BASIMP4]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_BASIMP5_DF]  DEFAULT ((0)) FOR [F2_BASIMP5]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_BASIMP6_DF]  DEFAULT ((0)) FOR [F2_BASIMP6]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALIMP1_DF]  DEFAULT ((0)) FOR [F2_VALIMP1]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALIMP2_DF]  DEFAULT ((0)) FOR [F2_VALIMP2]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALIMP3_DF]  DEFAULT ((0)) FOR [F2_VALIMP3]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALIMP4_DF]  DEFAULT ((0)) FOR [F2_VALIMP4]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALIMP5_DF]  DEFAULT ((0)) FOR [F2_VALIMP5]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALIMP6_DF]  DEFAULT ((0)) FOR [F2_VALIMP6]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_ORDPAGO_DF]  DEFAULT ('      ') FOR [F2_ORDPAGO]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_NFCUPOM_DF]  DEFAULT ('            ') FOR [F2_NFCUPOM]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALINSS_DF]  DEFAULT ((0)) FOR [F2_VALINSS]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_HORA_DF]  DEFAULT ('     ') FOR [F2_HORA]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_MOEDA_DF]  DEFAULT ((0)) FOR [F2_MOEDA]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_REGIAO_DF]  DEFAULT ('   ') FOR [F2_REGIAO]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALCSLL_DF]  DEFAULT ((0)) FOR [F2_VALCSLL]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALCOFI_DF]  DEFAULT ((0)) FOR [F2_VALCOFI]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALPIS_DF]  DEFAULT ((0)) FOR [F2_VALPIS]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_LOTE_DF]  DEFAULT (' ') FOR [F2_LOTE]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_TXMOEDA_DF]  DEFAULT ((0)) FOR [F2_TXMOEDA]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALIRRF_DF]  DEFAULT ((0)) FOR [F2_VALIRRF]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_CARGA_DF]  DEFAULT ('      ') FOR [F2_CARGA]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_RECFAUT_DF]  DEFAULT (' ') FOR [F2_RECFAUT]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_SEQCAR_DF]  DEFAULT ('  ') FOR [F2_SEQCAR]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_BASEINS_DF]  DEFAULT ((0)) FOR [F2_BASEINS]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_PEDPEND_DF]  DEFAULT ('      ') FOR [F2_PEDPEND]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_DESCCAB_DF]  DEFAULT ((0)) FOR [F2_DESCCAB]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_DTENTR_DF]  DEFAULT ('        ') FOR [F2_DTENTR]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_FORMUL_DF]  DEFAULT (' ') FOR [F2_FORMUL]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_TIPODOC_DF]  DEFAULT ('  ') FOR [F2_TIPODOC]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_NFEACRS_DF]  DEFAULT ('         ') FOR [F2_NFEACRS]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_TIPOREM_DF]  DEFAULT (' ') FOR [F2_TIPOREM]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_SEQENT_DF]  DEFAULT ('      ') FOR [F2_SEQENT]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_ICMSDIF_DF]  DEFAULT ((0)) FOR [F2_ICMSDIF]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALACRS_DF]  DEFAULT ((0)) FOR [F2_VALACRS]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_RECISS_DF]  DEFAULT (' ') FOR [F2_RECISS]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_HAWB_DF]  DEFAULT ('                 ') FOR [F2_HAWB]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_BASEPS3_DF]  DEFAULT ((0)) FOR [F2_BASEPS3]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALPS3_DF]  DEFAULT ((0)) FOR [F2_VALPS3]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_BASECF3_DF]  DEFAULT ((0)) FOR [F2_BASECF3]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALCF3_DF]  DEFAULT ((0)) FOR [F2_VALCF3]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VEICUL1_DF]  DEFAULT ('        ') FOR [F2_VEICUL1]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VEICUL2_DF]  DEFAULT ('        ') FOR [F2_VEICUL2]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_NFELETR_DF]  DEFAULT ('                    ') FOR [F2_NFELETR]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_EMINFE_DF]  DEFAULT ('        ') FOR [F2_EMINFE]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_HORNFE_DF]  DEFAULT ('        ') FOR [F2_HORNFE]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_CODNFE_DF]  DEFAULT ('                                                  ') FOR [F2_CODNFE]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_CREDNFE_DF]  DEFAULT ((0)) FOR [F2_CREDNFE]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_TIPORET_DF]  DEFAULT (' ') FOR [F2_TIPORET]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALTST_DF]  DEFAULT ((0)) FOR [F2_VALTST]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_ESTCRED_DF]  DEFAULT ((0)) FOR [F2_ESTCRED]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_CHVNFE_DF]  DEFAULT ('                                            ') FOR [F2_CHVNFE]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_DIACTB_DF]  DEFAULT ('  ') FOR [F2_DIACTB]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_NODIA_DF]  DEFAULT ('          ') FOR [F2_NODIA]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_BASEIRR_DF]  DEFAULT ((0)) FOR [F2_BASEIRR]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_FILDEST_DF]  DEFAULT ('  ') FOR [F2_FILDEST]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_DTDIGIT_DF]  DEFAULT ('        ') FOR [F2_DTDIGIT]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VEICUL3_DF]  DEFAULT ('        ') FOR [F2_VEICUL3]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VLR_FRT_DF]  DEFAULT ((0)) FOR [F2_VLR_FRT]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_BASETST_DF]  DEFAULT ((0)) FOR [F2_BASETST]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALFDS_DF]  DEFAULT ((0)) FOR [F2_VALFDS]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_CLIENT_DF]  DEFAULT ('      ') FOR [F2_CLIENT]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_LOJENT_DF]  DEFAULT ('  ') FOR [F2_LOJENT]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_FLAGDEV_DF]  DEFAULT (' ') FOR [F2_FLAGDEV]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_TPNFEXP_DF]  DEFAULT (' ') FOR [F2_TPNFEXP]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_D_E_L_E_T__DF]  DEFAULT (' ') FOR [D_E_L_E_T_]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_R_E_C_N_O__DF]  DEFAULT ((0)) FOR [R_E_C_N_O_]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_R_E_C_D_E_L__DF]  DEFAULT ((0)) FOR [R_E_C_D_E_L_]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_ATEND_DF]  DEFAULT ((0)) FOR [F2_X_ATEND]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_TPFRE_DF]  DEFAULT (' ') FOR [F2_X_TPFRE]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_FORMA_DF]  DEFAULT ('   ') FOR [F2_X_FORMA]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_MENNF_DF]  DEFAULT ('                                                            ') FOR [F2_X_MENNF]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_NF_DF]  DEFAULT ('            ') FOR [F2_X_NF]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_AGRUP_DF]  DEFAULT ('      ') FOR [F2_X_AGRUP]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_PLACA_DF]  DEFAULT ('       ') FOR [F2_X_PLACA]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_SITUA_DF]  DEFAULT ('   ') FOR [F2_X_SITUA]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_DTFAT_DF]  DEFAULT ('        ') FOR [F2_X_DTFAT]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_HRFAT_DF]  DEFAULT ('        ') FOR [F2_X_HRFAT]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_USFAT_DF]  DEFAULT ('                    ') FOR [F2_X_USFAT]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_DTEXC_DF]  DEFAULT ('        ') FOR [F2_X_DTEXC]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_HREXC_DF]  DEFAULT ('        ') FOR [F2_X_HREXC]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_USEXC_DF]  DEFAULT ('                    ') FOR [F2_X_USEXC]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2__SERIE_DF]  DEFAULT (' ') FOR [F2__SERIE]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_ADMFI_DF]  DEFAULT ('   ') FOR [F2_X_ADMFI]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_CLICC_DF]  DEFAULT ('      ') FOR [F2_X_CLICC]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_LOJCC_DF]  DEFAULT ('  ') FOR [F2_X_LOJCC]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_VEND2_DF]  DEFAULT ('      ') FOR [F2_X_VEND2]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_VEND3_DF]  DEFAULT ('      ') FOR [F2_X_VEND3]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_PEDSE_DF]  DEFAULT (' ') FOR [F2_X_PEDSE]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_EXPDP_DF]  DEFAULT (' ') FOR [F2_X_EXPDP]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_STDEL_DF]  DEFAULT (' ') FOR [F2_X_STDEL]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_CODEN_DF]  DEFAULT ('      ') FOR [F2_X_CODEN]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_UGERO_DF]  DEFAULT ('                              ') FOR [F2_X_UGERO]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_DGERO_DF]  DEFAULT ('                              ') FOR [F2_X_DGERO]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_HGERO_DF]  DEFAULT ('                              ') FOR [F2_X_HGERO]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_UIMRO_DF]  DEFAULT ('                              ') FOR [F2_X_UIMRO]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_DIMRO_DF]  DEFAULT ('                              ') FOR [F2_X_DIMRO]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_HIMRO_DF]  DEFAULT ('                              ') FOR [F2_X_HIMRO]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_UEXRO_DF]  DEFAULT ('                              ') FOR [F2_X_UEXRO]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_DEXRO_DF]  DEFAULT ('                              ') FOR [F2_X_DEXRO]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_HEXRO_DF]  DEFAULT ('                              ') FOR [F2_X_HEXRO]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_UFIRO_DF]  DEFAULT ('                              ') FOR [F2_X_UFIRO]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_DFIRO_DF]  DEFAULT ('                              ') FOR [F2_X_DFIRO]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_HFIRO_DF]  DEFAULT ('                              ') FOR [F2_X_HFIRO]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_ORDRO_DF]  DEFAULT ('   ') FOR [F2_X_ORDRO]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_NFICMST_DF]  DEFAULT ('            ') FOR [F2_NFICMST]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_TPFRETE_DF]  DEFAULT (' ') FOR [F2_TPFRETE]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALFAB_DF]  DEFAULT ((0)) FOR [F2_VALFAB]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALFAC_DF]  DEFAULT ((0)) FOR [F2_VALFAC]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALFET_DF]  DEFAULT ((0)) FOR [F2_VALFET]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_NCART_DF]  DEFAULT ('                   ') FOR [F2_X_NCART]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_FLGIM_DF]  DEFAULT (' ') FOR [F2_X_FLGIM]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_IMPBO_DF]  DEFAULT (' ') FOR [F2_X_IMPBO]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_BASEFUN_DF]  DEFAULT ((0)) FOR [F2_BASEFUN]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_NFSUBST_DF]  DEFAULT ('         ') FOR [F2_NFSUBST]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_SERSUBS_DF]  DEFAULT ('   ') FOR [F2_SERSUBS]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VLSENAR_DF]  DEFAULT ((0)) FOR [F2_VLSENAR]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_NTFECP_DF]  DEFAULT ('            ') FOR [F2_NTFECP]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_RECOPI_DF]  DEFAULT (' ') FOR [F2_RECOPI]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALINA_DF]  DEFAULT ((0)) FOR [F2_VALINA]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_BASEINA_DF]  DEFAULT ((0)) FOR [F2_BASEINA]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_BASPIS_DF]  DEFAULT ((0)) FOR [F2_BASPIS]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_BASCOFI_DF]  DEFAULT ((0)) FOR [F2_BASCOFI]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_BASCSLL_DF]  DEFAULT ((0)) FOR [F2_BASCSLL]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_DESCZFR_DF]  DEFAULT ((0)) FOR [F2_DESCZFR]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_DTTXREF_DF]  DEFAULT ('        ') FOR [F2_DTTXREF]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_TXREF_DF]  DEFAULT ((0)) FOR [F2_TXREF]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_X_NUMRO_DF]  DEFAULT ('          ') FOR [F2_X_NUMRO]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_CLEOK_DF]  DEFAULT ('    ') FOR [F2_CLEOK]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_EVENFLG_DF]  DEFAULT (' ') FOR [F2_EVENFLG]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_CHVCLE_DF]  DEFAULT ('              ') FOR [F2_CHVCLE]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_IDCCE_DF]  DEFAULT ('                                                      ') FOR [F2_IDCCE]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_IDCLE_DF]  DEFAULT ('            ') FOR [F2_IDCLE]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VREINT_DF]  DEFAULT ((0)) FOR [F2_VREINT]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_BSREIN_DF]  DEFAULT ((0)) FOR [F2_BSREIN]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_MENNOTA_DF]  DEFAULT ('                                                            ') FOR [F2_MENNOTA]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_FLAGRGS_DF]  DEFAULT ('    ') FOR [F2_FLAGRGS]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_IDRGS_DF]  DEFAULT ('                                                      ') FOR [F2_IDRGS]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_CODRGS_DF]  DEFAULT (' ') FOR [F2_CODRGS]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_DAUTNFE_DF]  DEFAULT ('        ') FOR [F2_DAUTNFE]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_HAUTNFE_DF]  DEFAULT ('     ') FOR [F2_HAUTNFE]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_ORDSEP_DF]  DEFAULT ('      ') FOR [F2_ORDSEP]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_CGCCLI_DF]  DEFAULT ('                ') FOR [F2_CGCCLI]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_REFTAXA_DF]  DEFAULT ((0)) FOR [F2_REFTAXA]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_REFMOED_DF]  DEFAULT ((0)) FOR [F2_REFMOED]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_PREFORI_DF]  DEFAULT ('   ') FOR [F2_PREFORI]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_TOTIMP_DF]  DEFAULT ((0)) FOR [F2_TOTIMP]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_TIPIMP_DF]  DEFAULT (' ') FOR [F2_TIPIMP]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_IDRECOP_DF]  DEFAULT ('      ') FOR [F2_IDRECOP]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_TOTFED_DF]  DEFAULT ((0)) FOR [F2_TOTFED]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_TOTEST_DF]  DEFAULT ((0)) FOR [F2_TOTEST]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_TOTMUN_DF]  DEFAULT ((0)) FOR [F2_TOTMUN]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VLCPM_DF]  DEFAULT ((0)) FOR [F2_VLCPM]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_BASECPM_DF]  DEFAULT ((0)) FOR [F2_BASECPM]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALFMP_DF]  DEFAULT ((0)) FOR [F2_VALFMP]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_BASEFMP_DF]  DEFAULT ((0)) FOR [F2_BASEFMP]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALFMD_DF]  DEFAULT ((0)) FOR [F2_VALFMD]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_FORMDES_DF]  DEFAULT (' ') FOR [F2_FORMDES]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_NUMORC_DF]  DEFAULT ('      ') FOR [F2_NUMORC]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_IDSA1_DF]  DEFAULT ('                    ') FOR [F2_IDSA1]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_IDSA2_DF]  DEFAULT ('                    ') FOR [F2_IDSA2]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_IDSED_DF]  DEFAULT ('                    ') FOR [F2_IDSED]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_LOJADES_DF]  DEFAULT ('  ') FOR [F2_LOJADES]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_FORDES_DF]  DEFAULT ('      ') FOR [F2_FORDES]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_GNRFECP_DF]  DEFAULT ('            ') FOR [F2_GNRFECP]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_GNRDIF_DF]  DEFAULT ('            ') FOR [F2_GNRDIF]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_DTESERV_DF]  DEFAULT ('        ') FOR [F2_DTESERV]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALFUND_DF]  DEFAULT ((0)) FOR [F2_VALFUND]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALIMA_DF]  DEFAULT ((0)) FOR [F2_VALIMA]
GO
ALTER TABLE [dbo].[SF2010] ADD  CONSTRAINT [SF2010_F2_VALFASE_DF]  DEFAULT ((0)) FOR [F2_VALFASE]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_FILIAL_DF]  DEFAULT ('  ') FOR [F4_FILIAL]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CODIGO_DF]  DEFAULT ('   ') FOR [F4_CODIGO]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TIPO_DF]  DEFAULT (' ') FOR [F4_TIPO]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_ICM_DF]  DEFAULT (' ') FOR [F4_ICM]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_IPI_DF]  DEFAULT (' ') FOR [F4_IPI]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CREDICM_DF]  DEFAULT (' ') FOR [F4_CREDICM]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CREDIPI_DF]  DEFAULT (' ') FOR [F4_CREDIPI]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_DUPLIC_DF]  DEFAULT (' ') FOR [F4_DUPLIC]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_ESTOQUE_DF]  DEFAULT (' ') FOR [F4_ESTOQUE]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CF_DF]  DEFAULT ('     ') FOR [F4_CF]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TEXTO_DF]  DEFAULT ('                    ') FOR [F4_TEXTO]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CFEXT_DF]  DEFAULT ('  ') FOR [F4_CFEXT]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_BASEICM_DF]  DEFAULT ((0)) FOR [F4_BASEICM]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_BASEIPI_DF]  DEFAULT ((0)) FOR [F4_BASEIPI]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_PODER3_DF]  DEFAULT (' ') FOR [F4_PODER3]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_LFICM_DF]  DEFAULT (' ') FOR [F4_LFICM]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_LFIPI_DF]  DEFAULT (' ') FOR [F4_LFIPI]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_DESTACA_DF]  DEFAULT (' ') FOR [F4_DESTACA]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_INCIDE_DF]  DEFAULT (' ') FOR [F4_INCIDE]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_COMPL_DF]  DEFAULT (' ') FOR [F4_COMPL]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_IPIFRET_DF]  DEFAULT (' ') FOR [F4_IPIFRET]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_ISS_DF]  DEFAULT (' ') FOR [F4_ISS]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_LFISS_DF]  DEFAULT (' ') FOR [F4_LFISS]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_NRLIVRO_DF]  DEFAULT (' ') FOR [F4_NRLIVRO]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_UPRC_DF]  DEFAULT (' ') FOR [F4_UPRC]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CONSUMO_DF]  DEFAULT (' ') FOR [F4_CONSUMO]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_FORMULA_DF]  DEFAULT ('   ') FOR [F4_FORMULA]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_AGREG_DF]  DEFAULT (' ') FOR [F4_AGREG]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_INCSOL_DF]  DEFAULT (' ') FOR [F4_INCSOL]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CIAP_DF]  DEFAULT (' ') FOR [F4_CIAP]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_DESPIPI_DF]  DEFAULT (' ') FOR [F4_DESPIPI]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_LIVRO_DF]  DEFAULT ('                                                                ') FOR [F4_LIVRO]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_ATUTEC_DF]  DEFAULT (' ') FOR [F4_ATUTEC]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_ATUATF_DF]  DEFAULT (' ') FOR [F4_ATUATF]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TPIPI_DF]  DEFAULT (' ') FOR [F4_TPIPI]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_STDESC_DF]  DEFAULT (' ') FOR [F4_STDESC]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_BSICMST_DF]  DEFAULT ((0)) FOR [F4_BSICMST]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CREDST_DF]  DEFAULT (' ') FOR [F4_CREDST]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_BASEISS_DF]  DEFAULT ((0)) FOR [F4_BASEISS]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_DESPICM_DF]  DEFAULT (' ') FOR [F4_DESPICM]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_SITTRIB_DF]  DEFAULT ('  ') FOR [F4_SITTRIB]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_PISCOF_DF]  DEFAULT (' ') FOR [F4_PISCOF]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_PISCRED_DF]  DEFAULT (' ') FOR [F4_PISCRED]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TESDV_DF]  DEFAULT ('   ') FOR [F4_TESDV]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_BASEPIS_DF]  DEFAULT ((0)) FOR [F4_BASEPIS]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_BASECOF_DF]  DEFAULT ((0)) FOR [F4_BASECOF]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_IPILICM_DF]  DEFAULT (' ') FOR [F4_IPILICM]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_MOVPRJ_DF]  DEFAULT (' ') FOR [F4_MOVPRJ]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_ICMSDIF_DF]  DEFAULT (' ') FOR [F4_ICMSDIF]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TESP3_DF]  DEFAULT ('   ') FOR [F4_TESP3]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_QTDZERO_DF]  DEFAULT (' ') FOR [F4_QTDZERO]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_SLDNPT_DF]  DEFAULT (' ') FOR [F4_SLDNPT]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_DEVZERO_DF]  DEFAULT (' ') FOR [F4_DEVZERO]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TIPOPER_DF]  DEFAULT (' ') FOR [F4_TIPOPER]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_MSBLQL_DF]  DEFAULT (' ') FOR [F4_MSBLQL]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TRFICM_DF]  DEFAULT (' ') FOR [F4_TRFICM]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TESENV_DF]  DEFAULT ('   ') FOR [F4_TESENV]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_OBSICM_DF]  DEFAULT (' ') FOR [F4_OBSICM]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_OBSSOL_DF]  DEFAULT (' ') FOR [F4_OBSSOL]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_PICMDIF_DF]  DEFAULT ((0)) FOR [F4_PICMDIF]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_SELO_DF]  DEFAULT (' ') FOR [F4_SELO]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_ISSST_DF]  DEFAULT (' ') FOR [F4_ISSST]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_FINALID_DF]  DEFAULT ('                                                                                                                                                                                                                                                              ') FOR [F4_FINALID]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_PISFISC_DF]  DEFAULT (' ') FOR [F4_PISFISC]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CONTSOC_DF]  DEFAULT (' ') FOR [F4_CONTSOC]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_RETISS_DF]  DEFAULT (' ') FOR [F4_RETISS]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CRDEST_DF]  DEFAULT (' ') FOR [F4_CRDEST]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_PISBRUT_DF]  DEFAULT (' ') FOR [F4_PISBRUT]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_COFBRUT_DF]  DEFAULT (' ') FOR [F4_COFBRUT]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_PISDSZF_DF]  DEFAULT (' ') FOR [F4_PISDSZF]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_COFDSZF_DF]  DEFAULT (' ') FOR [F4_COFDSZF]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_LFICMST_DF]  DEFAULT (' ') FOR [F4_LFICMST]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_AGRPIS_DF]  DEFAULT (' ') FOR [F4_AGRPIS]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_AGRCOF_DF]  DEFAULT (' ') FOR [F4_AGRCOF]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_BCRDPIS_DF]  DEFAULT ((0)) FOR [F4_BCRDPIS]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_BCRDCOF_DF]  DEFAULT ((0)) FOR [F4_BCRDCOF]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_ICMSST_DF]  DEFAULT (' ') FOR [F4_ICMSST]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_BENSATF_DF]  DEFAULT (' ') FOR [F4_BENSATF]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_IPIPC_DF]  DEFAULT (' ') FOR [F4_IPIPC]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CRPRST_DF]  DEFAULT ((0)) FOR [F4_CRPRST]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TRANFIL_DF]  DEFAULT (' ') FOR [F4_TRANFIL]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_REGDSTA_DF]  DEFAULT (' ') FOR [F4_REGDSTA]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_OPEMOV_DF]  DEFAULT ('  ') FOR [F4_OPEMOV]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_AFRMM_DF]  DEFAULT (' ') FOR [F4_AFRMM]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CRDPRES_DF]  DEFAULT ((0)) FOR [F4_CRDPRES]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_DSPRDIC_DF]  DEFAULT (' ') FOR [F4_DSPRDIC]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TPREG_DF]  DEFAULT (' ') FOR [F4_TPREG]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CRPRELE_DF]  DEFAULT ((0)) FOR [F4_CRPRELE]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_AGRRETC_DF]  DEFAULT (' ') FOR [F4_AGRRETC]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CTIPI_DF]  DEFAULT ('  ') FOR [F4_CTIPI]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_FRETAUT_DF]  DEFAULT (' ') FOR [F4_FRETAUT]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_MKPCMP_DF]  DEFAULT (' ') FOR [F4_MKPCMP]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TESE3_DF]  DEFAULT ('   ') FOR [F4_TESE3]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_PSCFST_DF]  DEFAULT (' ') FOR [F4_PSCFST]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_IPIOBS_DF]  DEFAULT (' ') FOR [F4_IPIOBS]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CFPS_DF]  DEFAULT ('      ') FOR [F4_CFPS]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CRDTRAN_DF]  DEFAULT ((0)) FOR [F4_CRDTRAN]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_ANTICMS_DF]  DEFAULT (' ') FOR [F4_ANTICMS]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_ESTCRED_DF]  DEFAULT ((0)) FOR [F4_ESTCRED]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_MKPSOL_DF]  DEFAULT (' ') FOR [F4_MKPSOL]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CRPREPR_DF]  DEFAULT ((0)) FOR [F4_CRPREPR]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_BCPCST_DF]  DEFAULT (' ') FOR [F4_BCPCST]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CLFDSUL_DF]  DEFAULT (' ') FOR [F4_CLFDSUL]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_COMPRED_DF]  DEFAULT (' ') FOR [F4_COMPRED]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CSTPIS_DF]  DEFAULT ('  ') FOR [F4_CSTPIS]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CSTCOF_DF]  DEFAULT ('  ') FOR [F4_CSTCOF]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_RGESPST_DF]  DEFAULT (' ') FOR [F4_RGESPST]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CALCFET_DF]  DEFAULT (' ') FOR [F4_CALCFET]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_D_E_L_E_T__DF]  DEFAULT (' ') FOR [D_E_L_E_T_]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_R_E_C_N_O__DF]  DEFAULT ((0)) FOR [R_E_C_N_O_]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_R_E_C_D_E_L__DF]  DEFAULT ((0)) FOR [R_E_C_D_E_L_]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TRANSIT_DF]  DEFAULT (' ') FOR [F4_TRANSIT]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_AGRDRED_DF]  DEFAULT (' ') FOR [F4_AGRDRED]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CREDACU_DF]  DEFAULT (' ') FOR [F4_CREDACU]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_PCREDAC_DF]  DEFAULT ((0)) FOR [F4_PCREDAC]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_OPERSUC_DF]  DEFAULT (' ') FOR [F4_OPERSUC]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CRPRSIM_DF]  DEFAULT ((0)) FOR [F4_CRPRSIM]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_DESCOND_DF]  DEFAULT (' ') FOR [F4_DESCOND]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CRPRERO_DF]  DEFAULT ((0)) FOR [F4_CRPRERO]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_ISEFECP_DF]  DEFAULT (' ') FOR [F4_ISEFECP]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_INTBSIC_DF]  DEFAULT (' ') FOR [F4_INTBSIC]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CRICMS_DF]  DEFAULT (' ') FOR [F4_CRICMS]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_X_DESCR_DF]  DEFAULT ('                                        ') FOR [F4_X_DESCR]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_X_COD_DF]  DEFAULT ('   ') FOR [F4_X_COD]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_X_CDEB_DF]  DEFAULT ('                    ') FOR [F4_X_CDEB]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_X_CCRE_DF]  DEFAULT ('                    ') FOR [F4_X_CCRE]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_X_ICMDE_DF]  DEFAULT ('                    ') FOR [F4_X_ICMDE]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_X_ICMCR_DF]  DEFAULT ('                    ') FOR [F4_X_ICMCR]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_X_IPIDE_DF]  DEFAULT ('                    ') FOR [F4_X_IPIDE]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_X_IPICR_DF]  DEFAULT ('                    ') FOR [F4_X_IPICR]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_X_PISDE_DF]  DEFAULT ('                    ') FOR [F4_X_PISDE]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_X_PISCR_DF]  DEFAULT ('                    ') FOR [F4_X_PISCR]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_X_COFDE_DF]  DEFAULT ('                    ') FOR [F4_X_COFDE]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_X_COFCR_DF]  DEFAULT ('                    ') FOR [F4_X_COFCR]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_X_CSLDE_DF]  DEFAULT ('                    ') FOR [F4_X_CSLDE]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_X_CSLCR_DF]  DEFAULT ('                    ') FOR [F4_X_CSLCR]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_X_SUBDE_DF]  DEFAULT ('                    ') FOR [F4_X_SUBDE]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_X_SUBCR_DF]  DEFAULT ('                    ') FOR [F4_X_SUBCR]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_X_CONT_DF]  DEFAULT (' ') FOR [F4_X_CONT]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_X_HIST_DF]  DEFAULT ('                                        ') FOR [F4_X_HIST]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_X_MENNF_DF]  DEFAULT ('   ') FOR [F4_X_MENNF]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_X_TIPO_DF]  DEFAULT (' ') FOR [F4_X_TIPO]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4__STPISO_DF]  DEFAULT ('  ') FOR [F4__STPISO]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4__STCOFO_DF]  DEFAULT ('  ') FOR [F4__STCOFO]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4__STPISN_DF]  DEFAULT ('  ') FOR [F4__STPISN]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4__STCOFN_DF]  DEFAULT ('  ') FOR [F4__STCOFN]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_X_ISSDE_DF]  DEFAULT ('                    ') FOR [F4_X_ISSDE]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_X_ISSCR_DF]  DEFAULT ('                    ') FOR [F4_X_ISSCR]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CRDACUM_DF]  DEFAULT (' ') FOR [F4_CRDACUM]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_IVAUTIL_DF]  DEFAULT ((0)) FOR [F4_IVAUTIL]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_PERCMED_DF]  DEFAULT ((0)) FOR [F4_PERCMED]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CODDET_DF]  DEFAULT ('    ') FOR [F4_CODDET]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TIPODUB_DF]  DEFAULT (' ') FOR [F4_TIPODUB]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_BENDUB_DF]  DEFAULT (' ') FOR [F4_BENDUB]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_NUMDUB_DF]  DEFAULT ('            ') FOR [F4_NUMDUB]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_DBSTCSL_DF]  DEFAULT (' ') FOR [F4_DBSTCSL]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_DBSTIRR_DF]  DEFAULT (' ') FOR [F4_DBSTIRR]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CROUTGO_DF]  DEFAULT ((0)) FOR [F4_CROUTGO]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CSTISS_DF]  DEFAULT ('  ') FOR [F4_CSTISS]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_REFATAN_DF]  DEFAULT (' ') FOR [F4_REFATAN]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_DUPLIST_DF]  DEFAULT (' ') FOR [F4_DUPLIST]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_BSRDICM_DF]  DEFAULT (' ') FOR [F4_BSRDICM]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CFACS_DF]  DEFAULT (' ') FOR [F4_CFACS]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CFABOV_DF]  DEFAULT (' ') FOR [F4_CFABOV]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_VARATAC_DF]  DEFAULT (' ') FOR [F4_VARATAC]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_MOVFIS_DF]  DEFAULT (' ') FOR [F4_MOVFIS]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_PRZESP_DF]  DEFAULT (' ') FOR [F4_PRZESP]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_VLAGREG_DF]  DEFAULT (' ') FOR [F4_VLAGREG]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_APLIRED_DF]  DEFAULT (' ') FOR [F4_APLIRED]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_APLIIVA_DF]  DEFAULT (' ') FOR [F4_APLIIVA]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_APLREDP_DF]  DEFAULT (' ') FOR [F4_APLREDP]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_PAUTICM_DF]  DEFAULT (' ') FOR [F4_PAUTICM]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_ATACVAR_DF]  DEFAULT (' ') FOR [F4_ATACVAR]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_STCONF_DF]  DEFAULT (' ') FOR [F4_STCONF]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_BSRURAL_DF]  DEFAULT (' ') FOR [F4_BSRURAL]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_REDANT_DF]  DEFAULT ((0)) FOR [F4_REDANT]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CRPRESP_DF]  DEFAULT ((0)) FOR [F4_CRPRESP]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CPRESPR_DF]  DEFAULT ((0)) FOR [F4_CPRESPR]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CRPREPE_DF]  DEFAULT ((0)) FOR [F4_CRPREPE]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_MOTICMS_DF]  DEFAULT ('  ') FOR [F4_MOTICMS]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_ICMSTMT_DF]  DEFAULT (' ') FOR [F4_ICMSTMT]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CROUTSP_DF]  DEFAULT ((0)) FOR [F4_CROUTSP]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CSOSN_DF]  DEFAULT ('   ') FOR [F4_CSOSN]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_ART274_DF]  DEFAULT (' ') FOR [F4_ART274]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CODPAG_DF]  DEFAULT ('  ') FOR [F4_CODPAG]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_PAGCOM_DF]  DEFAULT (' ') FOR [F4_PAGCOM]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_VDASOFT_DF]  DEFAULT (' ') FOR [F4_VDASOFT]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_COP_DF]  DEFAULT ('    ') FOR [F4_COP]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TRAFILI_DF]  DEFAULT (' ') FOR [F4_TRAFILI]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_AJUSTE_DF]  DEFAULT (' ') FOR [F4_AJUSTE]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CODBCC_DF]  DEFAULT ('  ') FOR [F4_CODBCC]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_INDNTFR_DF]  DEFAULT (' ') FOR [F4_INDNTFR]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_FRETISS_DF]  DEFAULT (' ') FOR [F4_FRETISS]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_ALSENAR_DF]  DEFAULT ((0)) FOR [F4_ALSENAR]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_AGREGCP_DF]  DEFAULT (' ') FOR [F4_AGREGCP]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CRLEIT_DF]  DEFAULT (' ') FOR [F4_CRLEIT]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_PR35701_DF]  DEFAULT ((0)) FOR [F4_PR35701]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_DESPPIS_DF]  DEFAULT (' ') FOR [F4_DESPPIS]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_DESPCOF_DF]  DEFAULT (' ') FOR [F4_DESPCOF]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CODLAN_DF]  DEFAULT ('      ') FOR [F4_CODLAN]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CPPRODE_DF]  DEFAULT ((0)) FOR [F4_CPPRODE]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TPPRODE_DF]  DEFAULT (' ') FOR [F4_TPPRODE]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TEMDOCS_DF]  DEFAULT (' ') FOR [F4_TEMDOCS]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_VENPRES_DF]  DEFAULT (' ') FOR [F4_VENPRES]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_REDBCCE_DF]  DEFAULT ((0)) FOR [F4_REDBCCE]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CODLEG_DF]  DEFAULT ('    ') FOR [F4_CODLEG]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_COMPONE_DF]  DEFAULT (' ') FOR [F4_COMPONE]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_REGESP_DF]  DEFAULT ('  ') FOR [F4_REGESP]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_RGESPCI_DF]  DEFAULT (' ') FOR [F4_RGESPCI]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TABGIAI_DF]  DEFAULT ('   ') FOR [F4_TABGIAI]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TABGIAO_DF]  DEFAULT ('   ') FOR [F4_TABGIAO]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TNATREC_DF]  DEFAULT ('    ') FOR [F4_TNATREC]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CNATREC_DF]  DEFAULT ('   ') FOR [F4_CNATREC]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_GRPNATR_DF]  DEFAULT ('  ') FOR [F4_GRPNATR]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_DTFIMNT_DF]  DEFAULT ('        ') FOR [F4_DTFIMNT]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_ISEFERN_DF]  DEFAULT (' ') FOR [F4_ISEFERN]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CODOBSE_DF]  DEFAULT ('      ') FOR [F4_CODOBSE]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CRICMST_DF]  DEFAULT (' ') FOR [F4_CRICMST]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_VLRZERO_DF]  DEFAULT (' ') FOR [F4_VLRZERO]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_NORESP_DF]  DEFAULT (' ') FOR [F4_NORESP]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TPDUP_DF]  DEFAULT (' ') FOR [F4_TPDUP]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_MALQCOF_DF]  DEFAULT ((0)) FOR [F4_MALQCOF]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TABGIAC_DF]  DEFAULT ('   ') FOR [F4_TABGIAC]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TPCPRES_DF]  DEFAULT (' ') FOR [F4_TPCPRES]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CONSIND_DF]  DEFAULT (' ') FOR [F4_CONSIND]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_ISEFEMG_DF]  DEFAULT (' ') FOR [F4_ISEFEMG]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_ISEFEMT_DF]  DEFAULT (' ') FOR [F4_ISEFEMT]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_APSCFST_DF]  DEFAULT (' ') FOR [F4_APSCFST]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_SOMAIPI_DF]  DEFAULT (' ') FOR [F4_SOMAIPI]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CREDPRE_DF]  DEFAULT ((0)) FOR [F4_CREDPRE]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TPRSPL_DF]  DEFAULT (' ') FOR [F4_TPRSPL]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CPRECTR_DF]  DEFAULT (' ') FOR [F4_CPRECTR]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_IPIANT_DF]  DEFAULT (' ') FOR [F4_IPIANT]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CTBHISS_DF]  DEFAULT ('         ') FOR [F4_CTBHISS]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CSBHISS_DF]  DEFAULT ('     ') FOR [F4_CSBHISS]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_MTRTBH_DF]  DEFAULT ('  ') FOR [F4_MTRTBH]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_RECDAC_DF]  DEFAULT (' ') FOR [F4_RECDAC]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_NATOPER_DF]  DEFAULT ('          ') FOR [F4_NATOPER]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_MSGLT_DF]  DEFAULT (' ') FOR [F4_MSGLT]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TIPOTES_DF]  DEFAULT (' ') FOR [F4_TIPOTES]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_BONIF_DF]  DEFAULT (' ') FOR [F4_BONIF]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_RESSARC_DF]  DEFAULT (' ') FOR [F4_RESSARC]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CIAPTRB_DF]  DEFAULT (' ') FOR [F4_CIAPTRB]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_FTATUSC_DF]  DEFAULT (' ') FOR [F4_FTATUSC]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_MALQPIS_DF]  DEFAULT ((0)) FOR [F4_MALQPIS]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_DICMFUN_DF]  DEFAULT (' ') FOR [F4_DICMFUN]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_DESTRUI_DF]  DEFAULT (' ') FOR [F4_DESTRUI]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_PERCATM_DF]  DEFAULT ((0)) FOR [F4_PERCATM]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_STLIQ_DF]  DEFAULT (' ') FOR [F4_STLIQ]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_RFETALG_DF]  DEFAULT (' ') FOR [F4_RFETALG]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_IMPIND_DF]  DEFAULT (' ') FOR [F4_IMPIND]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_DEVPARC_DF]  DEFAULT (' ') FOR [F4_DEVPARC]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_ESCRDPR_DF]  DEFAULT (' ') FOR [F4_ESCRDPR]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_OPERGAR_DF]  DEFAULT (' ') FOR [F4_OPERGAR]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_INDDET_DF]  DEFAULT (' ') FOR [F4_INDDET]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_PARTICM_DF]  DEFAULT (' ') FOR [F4_PARTICM]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_X_CMDEB_DF]  DEFAULT ('                    ') FOR [F4_X_CMDEB]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_X_CMCRE_DF]  DEFAULT ('                    ') FOR [F4_X_CMCRE]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CV139_DF]  DEFAULT (' ') FOR [F4_CV139]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_ALICRST_DF]  DEFAULT ((0)) FOR [F4_ALICRST]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_BSICMRE_DF]  DEFAULT (' ') FOR [F4_BSICMRE]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_IPIVFCF_DF]  DEFAULT (' ') FOR [F4_IPIVFCF]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_RDBSICM_DF]  DEFAULT (' ') FOR [F4_RDBSICM]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_INOVAUT_DF]  DEFAULT (' ') FOR [F4_INOVAUT]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CFAMAD_DF]  DEFAULT (' ') FOR [F4_CFAMAD]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_IDHIST_DF]  DEFAULT ('                    ') FOR [F4_IDHIST]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TRFICST_DF]  DEFAULT (' ') FOR [F4_TRFICST]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_OUTPERC_DF]  DEFAULT ((0)) FOR [F4_OUTPERC]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_PISMIN_DF]  DEFAULT (' ') FOR [F4_PISMIN]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_COFMIN_DF]  DEFAULT (' ') FOR [F4_COFMIN]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_IPIMIN_DF]  DEFAULT (' ') FOR [F4_IPIMIN]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_DESCISS_DF]  DEFAULT (' ') FOR [F4_DESCISS]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_ENQLEG_DF]  DEFAULT ('  ') FOR [F4_ENQLEG]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_IPMSP_DF]  DEFAULT ('                                                            ') FOR [F4_IPMSP]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_IPMMG_DF]  DEFAULT ('                                                            ') FOR [F4_IPMMG]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TREGDMA_DF]  DEFAULT ('  ') FOR [F4_TREGDMA]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CUSENTR_DF]  DEFAULT (' ') FOR [F4_CUSENTR]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_IPIPECR_DF]  DEFAULT ((0)) FOR [F4_IPIPECR]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_TXAPIPI_DF]  DEFAULT ('   ') FOR [F4_TXAPIPI]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_GRPCST_DF]  DEFAULT ('   ') FOR [F4_GRPCST]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CALCCPB_DF]  DEFAULT (' ') FOR [F4_CALCCPB]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_DIFAL_DF]  DEFAULT (' ') FOR [F4_DIFAL]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_BASCMP_DF]  DEFAULT ((0)) FOR [F4_BASCMP]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_DUPLIPI_DF]  DEFAULT (' ') FOR [F4_DUPLIPI]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_EFDF100_DF]  DEFAULT (' ') FOR [F4_EFDF100]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CSTPF1_DF]  DEFAULT ('  ') FOR [F4_CSTPF1]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CSTCF1_DF]  DEFAULT ('  ') FOR [F4_CSTCF1]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_FTRICMS_DF]  DEFAULT ((0)) FOR [F4_FTRICMS]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_AGRISS_DF]  DEFAULT (' ') FOR [F4_AGRISS]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CFUNDES_DF]  DEFAULT (' ') FOR [F4_CFUNDES]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CIMAMT_DF]  DEFAULT (' ') FOR [F4_CIMAMT]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_CFASE_DF]  DEFAULT (' ') FOR [F4_CFASE]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_INDVF_DF]  DEFAULT (' ') FOR [F4_INDVF]
GO
ALTER TABLE [dbo].[SF4010] ADD  CONSTRAINT [SF4010_F4_AGRPEDG_DF]  DEFAULT (' ') FOR [F4_AGRPEDG]
GO