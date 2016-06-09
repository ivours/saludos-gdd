using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WindowsFormsApplication1.Dominio
{
    public class Item
    {
        String descripcion;
        decimal importe;
        int cantidad;

        public void setDescripcion(String descripcion)
        {
            this.descripcion = descripcion;
        }

        public void setImporte(decimal importe)
        {
            this.importe = importe;
        }

        public void setCantidad(int cantidad)
        {
            this.cantidad = cantidad;
        }

        public String getDescripcion()
        {
            return this.descripcion;
        }

        public decimal getImporte()
        {
            return this.importe;
        }

        public int getCantidad()
        {
            return this.cantidad;
        }
    }
}
