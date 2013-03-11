#
# Import the required packages. 
# I always forget which are actually needed, so I import them all.
#
from scipy import *
from scipy.optimize import leastsq
import matplotlib.pylab as plt
import numpy as np
from math import *


def read_array(filename, dtype, separator=','):
    """ Read a file with an arbitrary number of columns.
        The type of data in each column is arbitrary
        It will be cast to the given dtype at runtime
    """
    cast = np.cast
    data = [[] for dummy in xrange(len(dtype))]
    for line in open(filename, 'r'):
        fields = line.strip().split(separator)
        for i, number in enumerate(fields):
            data[i].append(number)
    for i in xrange(len(dtype)):
        data[i] = cast[dtype[i]](data[i])
    return np.rec.array(data, dtype=dtype)

#
# Define your function to calculate the residuals. 
# The fitting function holds your parameter values.  
#
def residuals(p, y, x):
        err = y-pval(x,p)
        return err

def pval(x, p):
        return np.log10(10**(p[0]*x+p[1])-1)+p[2]

#
# Use scipy.io.array_import.read_array to read in your data
#
data = np.loadtxt('data.dat', delimiter=';')

x = data[:,0]
y = data[:,1]

#
# You must make a guess at the initial paramters.  
# Don't worry if you have a difficult time guessing at the
# optimal parameters, you can simply 'fine tune'.
#
A1_0=1.0
A2_0=0.3
A3_0=0.5

#
# The leastsq package calls the Levenberg-Marquandt algorithm.
#  
pname = (['A1','A2','A3'])
p0 = array([A1_0 , A2_0, A3_0])
plsq = leastsq(residuals, p0, args=(y, x), maxfev=2000)

#
# Now, plot your data
#
plt.plot(x,y,'ko',x,pval(x,plsq[0]),'k')
plt.title('Least-squares fit to PETR4')
plt.xlabel('x')
plt.ylabel('y')
plt.legend(['Data', 'Fit'],loc=4)
plt.show()

#
# Your best-fit paramters are kept within plsq[0].
#
print plsq[0]

#
# The sum of the residuals
#
resid = sum(np.sqrt((y-pval(x,plsq[0]))**2))
print resid
