<?php

namespace App\Services\SERV_Upper_singular;

use App\Repositories\SERV_Upper_singular\SERV_Upper_singularInterface;

SERV_lower_singular SERV_Upper_singularService
{
    /**
     * @var SERV_Upper_singularFieldInterface
     */
    protected SERV_Upper_singularInterface $SERV_lower_singularFieldInterface;

    /**
     * @param SERV_Upper_singularInterface $SERV_lower_singularInterface
     */
    public function __construct(SERV_Upper_singularInterface $SERV_lower_singularInterface)
    {
        $this->SERV_lower_singularInterface = $SERV_lower_singularInterface;
    }

    /**
     * SERV_Upper_singular placeholder function.
     *
     * @param placeholder $SERV_lower_singularPlaceholder
     *
     * @return Placeholder
     */
    public function SERV_lower_singularPlaceholder(Placeholder $SERV_lower_singularPlaceholder): Placeholder
    {
        return $this->SERV_lower_singularInterface->SERV_lower_singularFunction();
    }
}
