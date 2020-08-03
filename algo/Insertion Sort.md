# Insertion Sort

```java
package old.August;

import java.util.Scanner;

/**
 * Created by belobster on 16. 8. 29.
 */

public class Insertion {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int tc = sc.nextInt();
        int[][] o = new int[tc][2];
        for(int i=0; i<tc; i++){
            o[i][0] = sc.nextInt();
            o[i][1] = sc.nextInt();
        }

        array_sort(o);
        array_print(o);

    }

    private static void array_print(int[][] o) {

        for(int i=0; i<o.length; i++){
            System.out.println(o[i][0]+" "+o[i][1]);
        }
    }

    private static void array_sort(int[][] o) {

        for(int i=1; i<o.length; i++){

            int[] key = {o[i][0], o[i][1]};
            int pos = i;

            while(pos>0 && (o[pos-1][0]>=key[0])){
                // x좌표가 같다. y좌표로 비교한다.
                if(o[pos-1][0]==key[0]){
                    while(pos>0 && o[pos-1][0]==key[0] && o[pos-1][1]>=key[1]){
                        o[pos][0] = o[pos-1][0];
                        o[pos][1] = o[pos-1][1];
                        pos--;
                    }
                }
                // x좌표만으로 정렬 가능하다.
                else{
                    o[pos][0] = o[pos-1][0];
                    o[pos][1] = o[pos-1][1];
                    pos--;
                }
            }

            o[pos][0]=key[0];
            o[pos][1]=key[1];
        }

    }

    private static void array_bisort(int[][] o) {

        for(int i=1; i<o.length; i++){
            int l = 0, r = i, m = r/2;
            do{
                if(o[i][0]>o[m][0]) l=m+1;
                else if(o[i][0]<o[m][0]) r=m;
                else break;
                m = l+((r-l)/2);
            }while(l<r);

            if(m<i){
                int[] tmp = {o[i][0], o[i][1]};
                for(int j=i; j>m; j--){
                    o[j][0] = o[j-1][0];
                    o[j][1] = o[j-1][1];
                }
                o[m][0]=tmp[0];
                o[m][1]=tmp[1];
            }

        }


    }

}


```

