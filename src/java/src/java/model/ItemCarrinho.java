package model;

import java.io.Serializable;
import java.math.BigDecimal;

/** Representa um item dentro do carrinho de compras (guardado na sessão). */
public class ItemCarrinho implements Serializable {
    private Produto produto;
    private int quantidade;

    public ItemCarrinho() {}

    public ItemCarrinho(Produto produto, int quantidade) {
        this.produto = produto;
        this.quantidade = quantidade;
    }

    public Produto getProduto() { return produto; }
    public void setProduto(Produto produto) { this.produto = produto; }

    public int getQuantidade() { return quantidade; }
    public void setQuantidade(int quantidade) { this.quantidade = quantidade; }

    public BigDecimal getSubtotal() {
        return produto.getPreco().multiply(new BigDecimal(quantidade));
    }
}
