package model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;

public class Cupom implements Serializable {
    private int id;
    private String codigo;
    private String tipoDesconto; // PERCENTUAL ou VALOR_FIXO
    private BigDecimal valor;
    private Date validade;
    private boolean ativo;
    private Integer limiteUso;
    private int usos;

    public Cupom() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getCodigo() { return codigo; }
    public void setCodigo(String codigo) { this.codigo = codigo; }

    public String getTipoDesconto() { return tipoDesconto; }
    public void setTipoDesconto(String tipoDesconto) { this.tipoDesconto = tipoDesconto; }

    public BigDecimal getValor() { return valor; }
    public void setValor(BigDecimal valor) { this.valor = valor; }

    public Date getValidade() { return validade; }
    public void setValidade(Date validade) { this.validade = validade; }

    public boolean isAtivo() { return ativo; }
    public void setAtivo(boolean ativo) { this.ativo = ativo; }

    public Integer getLimiteUso() { return limiteUso; }
    public void setLimiteUso(Integer limiteUso) { this.limiteUso = limiteUso; }

    public int getUsos() { return usos; }
    public void setUsos(int usos) { this.usos = usos; }

    /** Calcula o valor do desconto sobre um subtotal. */
    public BigDecimal calcularDesconto(BigDecimal subtotal) {
        if ("PERCENTUAL".equalsIgnoreCase(tipoDesconto)) {
            return subtotal.multiply(valor).divide(new BigDecimal("100"));
        }
        return valor;
    }
}
