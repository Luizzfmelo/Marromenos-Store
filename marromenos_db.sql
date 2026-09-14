-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 14-Set-2026 às 19:59
-- Versão do servidor: 10.4.22-MariaDB
-- versão do PHP: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `marromenos_db`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `nome` varchar(60) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `categorias`
--

INSERT INTO `categorias` (`id`, `nome`, `descricao`) VALUES
(1, 'Calças', 'Calças jeans, sarja e moletom'),
(2, 'Tênis', 'Tênis casuais e esportivos'),
(3, 'Casacos', 'Jaquetas, moletons e casacos'),
(4, 'Camisas', 'Camisas e camisetas'),
(5, 'Acessórios', 'Bonés, cintos, bolsas e mais');

-- --------------------------------------------------------

--
-- Estrutura da tabela `cupons`
--

CREATE TABLE `cupons` (
  `id` int(11) NOT NULL,
  `codigo` varchar(30) NOT NULL,
  `tipo_desconto` enum('PERCENTUAL','VALOR_FIXO') NOT NULL DEFAULT 'PERCENTUAL',
  `valor` decimal(10,2) NOT NULL,
  `validade` date NOT NULL,
  `ativo` tinyint(1) NOT NULL DEFAULT 1,
  `limite_uso` int(11) DEFAULT NULL,
  `usos` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `cupons`
--

INSERT INTO `cupons` (`id`, `codigo`, `tipo_desconto`, `valor`, `validade`, `ativo`, `limite_uso`, `usos`) VALUES
(1, 'BEMVINDO10', 'PERCENTUAL', '10.00', '2026-12-31', 1, 100, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `eventos`
--

CREATE TABLE `eventos` (
  `id` int(11) NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `descricao` text DEFAULT NULL,
  `imagem_url` varchar(255) DEFAULT NULL,
  `data_inicio` date DEFAULT NULL,
  `data_fim` date DEFAULT NULL,
  `ativo` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `eventos`
--

INSERT INTO `eventos` (`id`, `titulo`, `descricao`, `imagem_url`, `data_inicio`, `data_fim`, `ativo`) VALUES
(1, 'Semana MarroMenos', 'Até 30% OFF em peças selecionadas!', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRalS-HvyTr63DhyY0tuiLtjQUCIxtixnR6I6Jk1kZA3gRO1OEeDecmxBc&s=10', '2026-08-01', '2026-09-30', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `itens_pedido`
--

CREATE TABLE `itens_pedido` (
  `id` int(11) NOT NULL,
  `pedido_id` int(11) NOT NULL,
  `produto_id` int(11) NOT NULL,
  `nome_produto` varchar(150) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `preco_unitario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `itens_pedido`
--

INSERT INTO `itens_pedido` (`id`, `pedido_id`, `produto_id`, `nome_produto`, `quantidade`, `preco_unitario`) VALUES
(1, 1, 2, 'Tênis Casual Branco', 1, '199.90'),
(2, 2, 6, 'New Balance 530', 1, '259.99'),
(3, 2, 1, 'Calça Jeans Slim', 1, '129.90'),
(4, 2, 2, 'Tênis Casual Branco', 1, '199.90'),
(5, 2, 7, 'Nike Mind 001', 23, '899.99');

-- --------------------------------------------------------

--
-- Estrutura da tabela `pedidos`
--

CREATE TABLE `pedidos` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `tipo_entrega` enum('ENTREGA','RETIRADA') NOT NULL DEFAULT 'RETIRADA',
  `endereco_entrega` varchar(255) DEFAULT NULL,
  `forma_pagamento` varchar(60) NOT NULL,
  `cupom_codigo` varchar(30) DEFAULT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `desconto` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'RECEBIDO',
  `data_pedido` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `pedidos`
--

INSERT INTO `pedidos` (`id`, `usuario_id`, `tipo_entrega`, `endereco_entrega`, `forma_pagamento`, `cupom_codigo`, `subtotal`, `desconto`, `total`, `status`, `data_pedido`) VALUES
(1, 2, 'RETIRADA', NULL, 'PIX', NULL, '199.90', '0.00', '199.90', 'RECEBIDO', '2026-09-09 18:13:22'),
(2, 1, 'RETIRADA', NULL, 'PIX', NULL, '21289.56', '0.00', '21289.56', 'RECEBIDO', '2026-09-09 18:33:43');

-- --------------------------------------------------------

--
-- Estrutura da tabela `produtos`
--

CREATE TABLE `produtos` (
  `id` int(11) NOT NULL,
  `nome` varchar(150) NOT NULL,
  `descricao` text DEFAULT NULL,
  `preco` decimal(10,2) NOT NULL,
  `tamanho` varchar(20) DEFAULT NULL,
  `cor` varchar(40) DEFAULT NULL,
  `estoque` int(11) NOT NULL DEFAULT 0,
  `imagem_url` varchar(255) DEFAULT NULL,
  `categoria_id` int(11) NOT NULL,
  `ativo` tinyint(1) NOT NULL DEFAULT 1,
  `data_cadastro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `produtos`
--

INSERT INTO `produtos` (`id`, `nome`, `descricao`, `preco`, `tamanho`, `cor`, `estoque`, `imagem_url`, `categoria_id`, `ativo`, `data_cadastro`) VALUES
(1, 'Calça Jeans Slim', 'Calça jeans slim fit masculina', '129.90', 'M', 'Azul', 19, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyCdwjdRHl2GaAOjUBAx4_TRc_BxziVq3vEMvm-L_9AYR7mUzGcJ-RZehI&s=10', 1, 1, '2026-09-03 17:56:49'),
(2, 'Tênis Casual Branco', 'Tênis casual unissex', '199.90', '40', 'Branco', 13, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRS6851g5vrctjRfDeMPe3s4pgHtNP6ciW89hXhucrEt-wIeLU9s_q4PBXO&s=10', 2, 1, '2026-09-03 17:56:49'),
(3, 'Jaqueta Corta Vento', 'Jaqueta corta vento com capuz', '159.90', 'G', 'Preto', 10, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeCCrXou625zxJd0X4-NKlU64O56CrZ-c1GP9MNzWvBqm3rzA4_KNmP9I&s=10', 3, 1, '2026-09-03 17:56:49'),
(4, 'Camisa Social Slim', 'Camisa social de manga longa', '89.90', 'M', 'Branco', 25, 'https://img.lojasrenner.com.br/item/542377734/original/3.jpg', 4, 1, '2026-09-03 17:56:49'),
(5, 'Boné Aba Reta', 'Boné aba reta ajustável', '49.90', 'Único', 'Laranja', 30, 'https://static.zattini.com.br/produtos/bone-59fifty-new-york-yankees-subway-series-aba-reta-fitted-marinho-new-era-fechado/12/BRJ-2918-012/BRJ-2918-012_zoom1.jpg?ts=1698258497', 5, 1, '2026-09-03 17:56:49'),
(6, 'New Balance 530', 'O New Balance 530 combina o estilo retrÃ´ dos anos 2000 com o conforto moderno do dia a dia. Com cabedal em mesh respirÃ¡vel e sobreposiÃ§Ãµes em sintÃ©tico, ele garante leveza, ventilaÃ§Ã£o e alta durabilidade.\r\n\r\nDestaques do produto:\r\n\r\nTecnologia ABZORB: Entressola que absorve o impacto, oferecendo amortecimento e conforto prolongado.\r\n\r\nEstilo Casual & Sportstyle: Perfeito para compor looks streetwear, esportivos ou casuais com um toque vintage.\r\n\r\nDesign Leve: ConstruÃ§Ã£o respirÃ¡vel ideal para uso diÃ¡rio e longas caminhadas.\r\n\r\nSolado de Borracha: TraÃ§Ã£o e aderÃªncia para diferentes tipos de solo.\r\n\r\nUma escolha versÃ¡til e atemporal para quem busca alinhar tendÃªncia e conforto no mesmo par.', '259.99', '41, 42, 43, 44, 45', 'Azul', 199, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlPu1_K6mfcMj6udbpxMoIJYHIcfrRymCQBNhNBIeR-Q&s=10', 5, 1, '2026-09-09 18:31:40'),
(7, 'Nike Mind 001', 'O Nike Mind 001 combina inovacao e design futurista com foco em conforto absoluto para o uso diario. Seu visual arrojado e moderno e perfeito para quem busca se destacar no estilo urban e streetwear.\r\n\r\nConforto Avancado: Amortecimento macio que garante absorcao de impacto a cada passo.\r\n\r\nCabedal Respiravel: Material leve que proporciona excelente ventilacao para os pes.\r\n\r\nDesign Inovador: Silueta moderna que se adapta facilmente a composicoes casuais e esportivas.\r\n\r\nSolado Resistente: Borracha de alta durabilidade para maior tracao e seguranca.\r\n\r\nUma escolha de destaque para quem procura tecnologia, estilo e praticidade em um so tenis.', '899.99', '42', 'Vermelho', 169, 'https://droper-lapse.us-southeast-1.linodeobjects.com/2025122318245553-926.webp', 2, 1, '2026-09-09 18:33:24');

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(120) NOT NULL,
  `email` varchar(150) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `endereco` varchar(255) DEFAULT NULL,
  `tipo` enum('CLIENTE','ADMIN') NOT NULL DEFAULT 'CLIENTE',
  `data_cadastro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `email`, `senha`, `telefone`, `endereco`, `tipo`, `data_cadastro`) VALUES
(1, 'Administrador MarroMenos', 'admin@marromenos.com', 'admin123', NULL, NULL, 'ADMIN', '2026-09-03 17:56:49'),
(2, 'Luiz123', 'luizzfmelo@gmail.com', 'aline4722', '61983798909', 'rua 1 lote 19 setor dos engenheiros', 'CLIENTE', '2026-09-09 18:12:38');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome` (`nome`);

--
-- Índices para tabela `cupons`
--
ALTER TABLE `cupons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codigo` (`codigo`);

--
-- Índices para tabela `eventos`
--
ALTER TABLE `eventos`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `itens_pedido`
--
ALTER TABLE `itens_pedido`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pedido_id` (`pedido_id`),
  ADD KEY `produto_id` (`produto_id`);

--
-- Índices para tabela `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Índices para tabela `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoria_id` (`categoria_id`);

--
-- Índices para tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `cupons`
--
ALTER TABLE `cupons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `eventos`
--
ALTER TABLE `eventos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `itens_pedido`
--
ALTER TABLE `itens_pedido`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `produtos`
--
ALTER TABLE `produtos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `itens_pedido`
--
ALTER TABLE `itens_pedido`
  ADD CONSTRAINT `itens_pedido_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `itens_pedido_ibfk_2` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`);

--
-- Limitadores para a tabela `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Limitadores para a tabela `produtos`
--
ALTER TABLE `produtos`
  ADD CONSTRAINT `produtos_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
