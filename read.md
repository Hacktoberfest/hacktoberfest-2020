#include <stdio.h>
#include<math.h>
int main(void) {
	// your code goes here
	int t;
	scanf("%d",&t);
	for(int i=0;i<t;i++)
	{
	    int n,m=0;
	    scanf("%d",&n);
	    int a[n],f[1000001];
	    for(int j=0;j<1000001;j++){
	        f[j]=0;
	    }
	    for(int j=0;j<n;j++){
	        scanf("%d",&a[j]);

	    }
	    for(int j=0;j<n;j++){
	        int val = f[a[j]];
 		        for(int k=1;k<=sqrt(a[j]);k++){
 		            if(a[j]%k==0)
 		            {
 		                f[k]++;
 		                if(k!=(a[j]/k)) f[a[j]/k]++;
 		            }
 		        }
 		    a[j] = val;
	    }
	    
	    for(int j=0;j<n;j++){
 		       
 		        if(a[j]>m)   m=a[j];
 		    } 
 		
 
 		printf("%d\n",m);    
	}
	return 0;
}
